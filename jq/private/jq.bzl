"""Implementation for jq rule"""

load("@bazel_lib//lib:expand_make_vars.bzl", "expand_variables")
load("@bazel_lib//lib:stamping.bzl", "STAMP_ATTRS", "maybe_stamp")
load("@bazel_lib//lib:strings.bzl", "split_args")
load("//jq/toolchain:toolchain.bzl", "TOOLCHAIN_TYPE")

_jq_attrs = dict({
    "srcs": attr.label_list(
        allow_files = True,
        mandatory = True,
        allow_empty = True,
    ),
    "data": attr.label_list(
        allow_files = True,
    ),
    "filter": attr.string(default = ""),
    "filter_file": attr.label(allow_single_file = True),
    "args": attr.string_list(),
    "expand_args": attr.bool(),
    "out": attr.output(),
    "_parse_status_file_filter": attr.label(
        allow_single_file = True,
        default = Label("//jq/private:parse_status_file.jq"),
    ),
}, **STAMP_ATTRS)

def _jq_action(ctx, sources, filter, out, args = [], data = []):
    """Run jq as a Bazel action.

    Args:
        ctx: The Bazel action context object
        sources: The list of source files jq should process
        filter: The filter expression string OR a file containing the filter for --from-file
        out: The output file
        args: Additional arguments to jq
        data: Files jq may need to read at runtime which are referenced in flags like --from-file

    Returns:
        The output file
    """
    jq_bin = ctx.toolchains[TOOLCHAIN_TYPE].jqinfo.bin

    # quote args that contain spaces
    quoted_args = []
    for a in args:
        if " " in a:
            a = "'{}'".format(a)
        quoted_args.append(a)

    data_inputs = data[:]
    if type(filter) == "string":
        quoted_args.append("'%s'" % filter)
    elif type(filter) == "File":
        quoted_args.extend(["--from-file", filter.path])
        data_inputs.append(filter)
    else:
        fail("Invalid filter type: %s" % type(filter))

    # jq hangs when there are no input sources unless --null-input flag is passed
    if len(sources) == 0 and "-n" not in args and "--null-input" not in args:
        quoted_args.append("--null-input")

    command = "{jq} {args} {sources} > {out}".format(
        jq = jq_bin.path,
        args = " ".join(quoted_args),
        sources = " ".join(["'%s'" % file.path for file in sources]),
        out = out.path,
    )

    ctx.actions.run_shell(
        tools = [jq_bin],
        inputs = sources + data_inputs,
        outputs = [out],
        command = command,
        mnemonic = "Jq",
        toolchain = TOOLCHAIN_TYPE,
    )

    return out

def _jq_impl(ctx):
    if ctx.attr.expand_args:
        args = []
        for a in ctx.attr.args:
            args += split_args(expand_variables(ctx, ctx.expand_location(a, targets = ctx.attr.data)))
    else:
        args = ctx.attr.args

    if not ctx.attr.filter and not ctx.attr.filter_file:
        fail("Must provide a filter or a filter_file")
    if ctx.attr.filter and ctx.attr.filter_file:
        fail("Cannot provide both a filter and a filter_file")

    data_inputs = ctx.files.data[:]
    stamp = maybe_stamp(ctx)
    if stamp:
        # create an action that gives a JSON representation of the stamp keys
        stamp_json = ctx.actions.declare_file("_%s_stamp.json" % ctx.label.name)
        data_inputs.append(stamp_json)
        stamp_inputs = [stamp.stable_status_file, stamp.volatile_status_file]
        _jq_action(ctx, stamp_inputs, ctx.file._parse_status_file_filter, args = ["--slurp", "--raw-input"], out = stamp_json)
        args = args + ["--slurpfile", "STAMP", stamp_json.path]

    out = _jq_action(ctx, ctx.files.srcs, ctx.attr.filter or ctx.file.filter_file, ctx.outputs.out or ctx.actions.declare_file(ctx.attr.name + ".json"), args, data_inputs)

    return DefaultInfo(files = depset([out]), runfiles = ctx.runfiles([out]))

jq_lib = struct(
    jq_action = _jq_action,
    attrs = _jq_attrs,
    implementation = _jq_impl,
)
