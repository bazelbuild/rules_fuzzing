# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Tools for replaying test files.

load("@rules_cc//cc:defs.bzl", "cc_library", "cc_test")

package(default_visibility = ["//fuzzing:__subpackages__"])

# Libraries.
############

cc_library(
    name = "status_util",
    srcs = ["status_util.cc"],
    hdrs = ["status_util.h"],
    deps = [
        "@com_google_absl//absl/status",
        "@com_google_absl//absl/strings",
    ],
)

# Tests.
########

cc_test(
    name = "status_util_test",
    size = "small",
    srcs = ["status_util_test.cc"],
    deps = [
        ":status_util",
        "@com_google_googletest//:gtest_main",
    ],
)