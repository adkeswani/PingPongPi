import unittest
from subprocess import check_output, CalledProcessError
import os
import shutil
import time

SCRIPT_CMD = "../checkLastCapture"
CAPTURES_DIR = "testCaptures"

def openFileAndGetModifiedTime(name):
    testFilePath = os.path.join(CAPTURES_DIR, name)
    testFile = open(testFilePath, "w")
    modifiedTime = check_output(["date", "-r", testFilePath])
    return testFilePath, modifiedTime

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

    def test_one_file(self):
        path, modified = openFileAndGetModifiedTime("test")
        output = check_output([SCRIPT_CMD, CAPTURES_DIR])

        self.assertEqual(output, "Last motion was " + path + " captured at " + modified)

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "test");

    def test_multiple_files(self):
        path, modified = openFileAndGetModifiedTime("test")
        time.sleep(1); # Otherwise the last modified times are too close together
        path2, modified2 = openFileAndGetModifiedTime("test2")
        output = check_output([SCRIPT_CMD, CAPTURES_DIR])

        self.assertEqual(output, "Last motion was " + path2 + " captured at " + modified2)

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "test2");

    def test_run_twice(self):
        path, modified = openFileAndGetModifiedTime("test")
        output = check_output([SCRIPT_CMD, CAPTURES_DIR])
        time.sleep(1); # Otherwise the last modified times are too close together
        path2, modified2 = openFileAndGetModifiedTime("test2")
        output = check_output([SCRIPT_CMD, CAPTURES_DIR])

        self.assertEqual(output, "Last motion was " + path2 + " captured at " + modified2)

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "test2");

if __name__ == '__main__':
    unittest.main()
