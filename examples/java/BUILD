# Copyright 2021 Google LLC
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

# Simple fuzz targets that demonstrate the Bazel extension functionality and
# serve as regression tests. Targets that are expected to crash or hang are
# disabled in the OSS-Fuzz integration using the "no-oss-fuzz" tag.

load("@rules_cc//cc:defs.bzl", "cc_binary")
load("//fuzzing:java_defs.bzl", "java_fuzz_test")

filegroup(
    name = "corpus",
    srcs = [
        "corpus_0.txt",
        "corpus_1.txt",
    ],
)

java_fuzz_test(
    name = "JavaEmptyFuzzTest",
    srcs = ["com/example/JavaEmptyFuzzTest.java"],
    corpus = [
        "corpus_0.txt",
    ],
)

java_fuzz_test(
    name = "JavaFuzzTest",
    srcs = ["com/example/JavaFuzzTest.java"],
)

java_fuzz_test(
    name = "JavaNativeFuzzTest",
    srcs = ["com/example/JavaNativeFuzzTest.java"],
    corpus = [
        ":corpus",
    ],
    transitive_native_deps = [
        ":native",
    ],
)

# A native library that interfaces with Java through the JNI.
cc_binary(
    name = "native",
    srcs = [
        "com/example/JavaNativeFuzzTest.cpp",
        "com/example/JavaNativeFuzzTest.h",
    ],
    linkshared = True,
    deps = [
        "@bazel_tools//tools/jdk:jni",
    ],
)