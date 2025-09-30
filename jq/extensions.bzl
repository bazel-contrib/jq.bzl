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

# def register_jq_toolchains(name = DEFAULT_JQ_REPOSITORY, version = DEFAULT_JQ_VERSION, register = True):
#     """Registers jq toolchain and repositories

#     Args:
#         name: override the prefix for the generated toolchain repositories
#         version: the version of jq to execute (see https://github.com/stedolan/jq/releases)
#         register: whether to call through to native.register_toolchains.
#             Should be True for WORKSPACE users, but false when used under bzlmod extension
#     """
#     for [platform, _] in JQ_PLATFORMS.items():
#         jq_platform_repo(
#             name = "%s_%s" % (name, platform),
#             platform = platform,
#             version = version,
#         )
#         if register:
#             native.register_toolchains("@%s_toolchains//:%s_toolchain" % (name, platform))

#     jq_host_alias_repo(name = name)

#     jq_toolchains_repo(
#         name = "%s_toolchains" % name,
#         user_repository_name = name,
#     )
