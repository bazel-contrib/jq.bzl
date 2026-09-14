"Support calls from MODULE.bazel to setup the toolchains"

load("//jq/toolchain:platforms.bzl", "JQ_PLATFORMS", "jq_platform_repo")
load("//jq/toolchain:toolchain.bzl", "DEFAULT_JQ_VERSION", "jq_host_alias_repo", "jq_toolchains_repo")

def _toolchains_extension(module_ctx):
    name = "jq"
    jq_toolchains_repo(name = "{}_toolchains".format(name), user_repository_name = name)
    for platform in JQ_PLATFORMS.keys():
        jq_platform_repo(
            name = "{}_{}".format(name, platform),
            platform = platform,
            version = DEFAULT_JQ_VERSION,
        )
    jq_host_alias_repo(name = name)
    return module_ctx.extension_metadata(reproducible = True)

toolchains = module_extension(
    implementation = _toolchains_extension,
)
