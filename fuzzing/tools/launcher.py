#
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

# Lint as: python3
"""
This is the launcher script to provide a uniform command line interface 
behind a number of arbitrary fuzzing engines.
"""

from absl import app
from absl import flags
import os

FLAGS = flags.FLAGS

flags.DEFINE_integer(
    "timeout_secs",
    20,
    "The maximum duration, in seconds, of the fuzzer run launched.",
    lower_bound=0)

flags.DEFINE_string("corpus_dir", "", 'The directory containing corpus.')


def main(argv):
    if len(argv) != 2:
        raise app.UsageError(
            "This script receives 1 argument. It should look like:" +
            "\n\tpython " + __file__ + " EXECUTABLE")

    if FLAGS.corpus_dir:
        os.execv(argv[1], [
            argv[1], FLAGS.corpus_dir, "-max_total_time=" +
            str(FLAGS.timeout_secs), "-timeout=" + str(FLAGS.timeout_secs)
        ])
    else:
        os.execv(argv[1], [
            argv[1], "-max_total_time=" + str(FLAGS.timeout_secs),
            "-timeout=" + str(FLAGS.timeout_secs)
        ])


if __name__ == '__main__':
    app.run(main)
