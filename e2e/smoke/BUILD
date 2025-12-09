load("@jq.bzl", "jq")
load("@jq.bzl//jq:jq.bzl", "jq_test")
load("@rules_shell//shell:sh_test.bzl", "sh_test")

jq(
    name = "no_srcs",
    srcs = [],
    filter = ".name = \"Alice\"",
)

jq_test(
    name = "smoke_test",
    file1 = "no_srcs.json",
    file2 = "no_srcs.json",
    filter1 = ".name",
    filter2 = "\"Alice\"",
)

sh_test(
    name = "jq_bin_test",
    srcs = ["tests/jq_bin.sh"],
    data = ["@jq_toolchains//:resolved_toolchain"],
    env = {"JQ_BIN": "$(JQ_BIN)"},
    toolchains = ["@jq_toolchains//:resolved_toolchain"],
    deps = ["@bazel_tools//tools/bash/runfiles"],
)
