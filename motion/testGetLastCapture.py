import unittest
import os
import shutil
import time
from getLastCapture import *

SCRIPT_ARG = "test.py"
CAPTURES_DIR = "testCaptures"

def createTestFile(name):
    testFilePath = os.path.join(CAPTURES_DIR, name)
    testFile = open(testFilePath, "w")
    return testFilePath

class TestGetLastCapture(unittest.TestCase):

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
        path = createTestFile("20150725190648.00.1437876408.jpg")

        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path + " " + "1437876408");

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "20150725190648.00.1437876408.jpg");

        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path + " " + "1437876408");

        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "20150725190648.00.1437876408.jpg");

    def test_multiple_files(self):
        path = createTestFile("20150725190648.00.1437876408.jpg")
        path2 = createTestFile("20150725190648.01.1437876408.jpg")
        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path2 + " " + "1437876408");
        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "20150725190648.01.1437876408.jpg");

        path3 = createTestFile("20150725190658.00.1437876418.jpg")
        self.assertEqual(main([SCRIPT_ARG, CAPTURES_DIR]), path3 + " " + "1437876418");
        captures = os.listdir(CAPTURES_DIR)
        self.assertEqual(len(captures), 1)
        self.assertEqual(captures[0], "20150725190658.00.1437876418.jpg");

if __name__ == '__main__':
    unittest.main()
