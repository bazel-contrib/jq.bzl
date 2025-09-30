load("@bazel_lib//:bzl_library.bzl", "bzl_library")

package(default_visibility = ["//visibility:public"])

toolchain_type(name = "type")

bzl_library(
    name = "toolchain",
    srcs = ["toolchain.bzl"],
    deps = [
        "//jq/toolchain:platforms",
        "@bazel_lib//lib:repo_utils",
    ],
)

bzl_library(
    name = "platforms",
    srcs = ["platforms.bzl"],
    deps = [":versions"],
)

bzl_library(
    name = "versions",
    srcs = ["versions.bzl"],
)
