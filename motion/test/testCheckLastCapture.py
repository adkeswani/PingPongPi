import unittest
from subprocess import check_output, CalledProcessError
import os
import shutil

SCRIPT_CMD = "../checkLastCapture"
TEST_DIR = "./test"
CAPTURES_DIR = "testCaptures"
CAPTURES_DIR_ARG = os.path.join(TEST_DIR, CAPTURES_DIR)

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
        check_output([SCRIPT_CMD, CAPTURES_DIR_ARG])

    def test_too_many_args(self):
        try:
            check_output([SCRIPT_CMD, CAPTURES_DIR_ARG, CAPTURES_DIR_ARG])
            self.assertTrue(False)
        except CalledProcessError as error:
            self.assertEqual(error.returncode, 1)
            self.assertEqual(error.output, "Usage: " + SCRIPT_CMD + " capturesDir\n")

if __name__ == '__main__':
    unittest.main()
