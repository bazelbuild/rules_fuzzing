#
#  Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

""" This file contains basic functions for fuzz test. """

load("@rules_cc//cc:defs.bzl", "cc_test")

def cc_fuzz_test(
        name,
        srcs,
        copts = [],
        linkopts = [],
        deps = [],
        tags = [],
        visibility = None):
    """ At present this cc_fuzz_test is just a wrapper of cc_test """

    cc_test(
        name = name,
        srcs = srcs,
        copts = ["-fsanitize=fuzzer"] + copts,
        linkopts = ["-fsanitize=fuzzer"] + linkopts,
        deps = deps,
        tags = tags,
        visibility = visibility,
    )
