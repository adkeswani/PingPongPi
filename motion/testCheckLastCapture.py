import unittest
import os
import shutil
import time
from checkLastCapture import *

SCRIPT_ARG = "test.py"
CAPTURES_DIR = "testCaptures"

def createTestFile(name):
    testFilePath = os.path.join(CAPTURES_DIR, name)
    testFile = open(testFilePath, "w")
    return testFilePath

class TestCheckLastCapture(unittest.TestCase):

    def setUp(self):
        os.makedirs(CAPTURES_DIR);

    def tearDown(self):
        shutil.rmtree(CAPTURES_DIR)

    def test_no_args(self):
        try:
            main([SCRIPT_ARG])
            self.assertTrue(False)
        except ValueError as error:
            self.assertEqual(error.message, "Usage: " + SCRIPT_ARG + " capturesDir")

    def test_correct_number_of_args(self):
        main([SCRIPT_ARG, CAPTURES_DIR])

    def test_too_many_args(self):
        try:
            main([SCRIPT_ARG, CAPTURES_DIR, SCRIPT_ARG])
            self.assertTrue(False)
        except ValueError as error:
            self.assertEqual(error.message, "Usage: " + SCRIPT_ARG + " capturesDir")

    def test_no_files(self):
        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), "")

    def test_one_file(self):
        path = createTestFile("01-20150621183214-02.jpg")

        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path);

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "01-20150621183214-02.jpg");

        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path);

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "01-20150621183214-02.jpg");

    def test_multiple_files(self):
        # Also ensure we are getting the last capture based on filename, not modified time
        path2 = createTestFile("01-20150621183215-00.jpg")
        time.sleep(1)
        path = createTestFile("01-20150621183214-02.jpg")

        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path2);

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "01-20150621183215-00.jpg");

        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path2);

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "01-20150621183215-00.jpg");

if __name__ == '__main__':
    unittest.main()
