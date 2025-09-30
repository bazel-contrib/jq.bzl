"Support calls from MODULE.bazel to setup the toolchains"

load("//jq/toolchain:platforms.bzl", "JQ_PLATFORMS", "jq_platform_repo")
load("//jq/toolchain:toolchain.bzl", "DEFAULT_JQ_VERSION", "jq_toolchains_repo")

def _toolchains_extension(_):
    jq_toolchains_repo(name = "jq_toolchains", user_repository_name = "jq_toolchains")
    for platform in JQ_PLATFORMS.keys():
        jq_platform_repo(
            name = "{}_{}".format("jq_toolchains", platform),
            platform = platform,
            version = DEFAULT_JQ_VERSION,
        )

toolchains = module_extension(
    implementation = _toolchains_extension,
)
