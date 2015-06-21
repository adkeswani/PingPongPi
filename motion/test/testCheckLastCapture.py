import unittest
from subprocess import check_output, CalledProcessError
import os
import shutil

SCRIPT_CMD = "../checkLastCapture"
CAPTURES_DIR = "testCaptures"

class TestCheckLastCapture(unittest.TestCase):

    def setUp(self):
        os.makedirs(CAPTURES_DIR);

    def tearDown(self):
        shutil.rmtree(CAPTURES_DIR)

    def test_no_args(self):
        try:
            check_output([SCRIPT_CMD])
            self.assertTrue(False)
        except CalledProcessError as error:
            self.assertEqual(error.returncode, 1)
            self.assertEqual(error.output, "Usage: " + SCRIPT_CMD + " capturesDir\n")

    def test_correct_number_of_args(self):
        check_output([SCRIPT_CMD, CAPTURES_DIR])

    def test_too_many_args(self):
        try:
            check_output([SCRIPT_CMD, CAPTURES_DIR, CAPTURES_DIR])
            self.assertTrue(False)
        except CalledProcessError as error:
            self.assertEqual(error.returncode, 1)
            self.assertEqual(error.output, "Usage: " + SCRIPT_CMD + " capturesDir\n")

    def test_no_files(self):
        output = check_output([SCRIPT_CMD, CAPTURES_DIR])
        self.assertEqual(output, "No captures found in " + CAPTURES_DIR + "\n");

if __name__ == '__main__':
    unittest.main()
