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

# TODO(sbucur): Add a flag for the fuzzer timeout.

command_line=("${FUZZER_BINARY}")
if [[ -n "${FUZZER_DICTIONARY_PATH}" ]]; then
    command_line+=("-dict=${FUZZER_DICTIONARY_PATH}")
fi
command_line+=("-artifact_prefix=${FUZZER_ARTIFACTS_DIR}/")
command_line+=("${FUZZER_OUTPUT_CORPUS_DIR}")

if [[ -n "${FUZZER_SEED_CORPUS_DIR}" ]]; then
    command_line+=("${FUZZER_SEED_CORPUS_DIR}")
fi

exec "${command_line[@]}"