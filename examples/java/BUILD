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
    name = "EmptyFuzzTest",
    srcs = ["com/example/EmptyFuzzTest.java"],
    corpus = [
        "corpus_0.txt",
    ],
)

java_fuzz_test(
    name = "FuzzTest",
    srcs = ["com/example/FuzzTest.java"],
    tags = [
        "no-oss-fuzz",
    ],
)

java_fuzz_test(
    name = "NativeFuzzTest",
    srcs = ["com/example/NativeFuzzTest.java"],
    corpus = [
        ":corpus",
    ],
    tags = [
        "no-oss-fuzz",
    ],
    deps = [
        ":native",
    ],
)

java_fuzz_test(
    name = "NativeRunfileFuzzTest",
    srcs = ["com/example/NativeRunfileFuzzTest.java"],
    data = [
        "corpus_0.txt",
    ],
    deps = [
        ":native_runfile",
        "@bazel_tools//tools/java/runfiles",
    ],
)

# A native library that interfaces with Java through the JNI.
cc_binary(
    name = "native",
    srcs = [
        "com/example/NativeFuzzTest.cpp",
        "com/example/NativeFuzzTest.h",
    ],
    linkshared = True,
    deps = [
        "@bazel_tools//tools/jdk:jni",
    ],
)

cc_binary(
    name = "native_runfile",
    srcs = [
        "com/example/NativeRunfileFuzzTest.cpp",
        "com/example/NativeRunfileFuzzTest.h",
    ],
    data = [
        "corpus_1.txt",
    ],
    # Build as a shared library that can be loaded by a Java application at
    # runtime via System.loadLibrary().
    linkshared = True,
    deps = [
        "@bazel_tools//tools/cpp/runfiles",
        "@bazel_tools//tools/jdk:jni",
    ],
)
