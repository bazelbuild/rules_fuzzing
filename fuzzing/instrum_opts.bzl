# Copyright 2020 Google LLC
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

"""Fuzz test instrumentation options.

Each fuzzing engine or sanitizer instrumentation recognized by the
//fuzzing:cc_engine_instrumentation and //fuzzing:cc_engine_sanitizer
configuration flag should be defined here.
"""

def _check_is_string_list(name, value):
    string_type = type("string")
    list_type = type(["list"])

    if type(value) != list_type:
        fail("%s should be a list, but was %s" % (name, type(value)))
    if any([type(element) != string_type for element in value]):
        fail("%s should be a list of strings" % name)

def instrumentation_opts(copts = [], linkopts = []):
    """Creates a set of instrumentation options.

    Args:
      copts: A list of compilation options to pass as `--copt`
        configuration flags.
      linkopts: A list of linker options to pass as `--linkopt`
        configuration flags.
    """
    _check_is_string_list("copts", copts)
    _check_is_string_list("linkopts", linkopts)
    return struct(
        copts = copts,
        linkopts = linkopts,
    )

# Base instrumentation applied to all fuzz test executables.
base_opts = instrumentation_opts(
    copts = ["-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION"],
    linkopts = [],
)

# Engine-specific instrumentation.
fuzzing_engine_opts = {
    "none": instrumentation_opts(),
    "libfuzzer": instrumentation_opts(
        copts = ["-fsanitize=fuzzer"],
        linkopts = ["-fsanitize=fuzzer"],
    ),
    # Reflects the set of options at
    # https://github.com/google/honggfuzz/blob/master/hfuzz_cc/hfuzz-cc.c
    "honggfuzz": instrumentation_opts(
        copts = [
            "-mllvm",
            "-inline-threshold=2000",
            "-fno-builtin",
            "-fno-omit-frame-pointer",
            "-D__NO_STRING_INLINES",
            "-fsanitize-coverage=trace-pc-guard,trace-cmp,trace-div,indirect-calls",
            "-fno-sanitize=fuzzer",
        ],
        linkopts = [
            "-fno-sanitize=fuzzer",
        ],
    ),
}

# Sanitizer-specific instrumentation.
sanitizer_opts = {
    "none": instrumentation_opts(),
    "asan": instrumentation_opts(
        copts = ["-fsanitize=address"],
        linkopts = ["-fsanitize=address"],
    ),
    "msan": instrumentation_opts(
        copts = ["-fsanitize=memory"],
        linkopts = ["-fsanitize=memory"],
    ),
    "msan-repro": instrumentation_opts(
        copts = [
            "-fsanitize=memory",
            "-fsanitize-memory-track-origins=2",
        ],
        linkopts = ["-fsanitize=memory"],
    ),
}
