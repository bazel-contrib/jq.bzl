"Support calls from MODULE.bazel to setup the toolchains"

load("//jq/toolchain:platforms.bzl", "JQ_PLATFORMS", "jq_platform_repo")
load("//jq/toolchain:toolchain.bzl", "DEFAULT_JQ_VERSION", "jq_host_alias_repo", "jq_toolchains_repo")

def _toolchains_extension(module_ctx):
    name = "jq"
    toolchains_repo_name = "{}_toolchains".format(name)
    jq_toolchains_repo(name = toolchains_repo_name, user_repository_name = toolchains_repo_name)
    for platform in JQ_PLATFORMS.keys():
        jq_platform_repo(
            name = "{}_{}".format(toolchains_repo_name, platform),
            platform = platform,
            version = DEFAULT_JQ_VERSION,
        )
    jq_host_alias_repo(name = name, toolchains_repo_name = toolchains_repo_name)
    return module_ctx.extension_metadata(reproducible = True)

toolchains = module_extension(
    implementation = _toolchains_extension,
)
