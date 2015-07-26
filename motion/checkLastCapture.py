import sys
import os

CAPTURE_TIME_IN_SECONDS_FIELD = 2

def getLastCaptureAndOthers(capturesDir):
    captures = os.listdir(capturesDir)
    if len(captures) == 0:
        return "", ""
    else:
        captures.sort()
        lastCapture = captures.pop()
        return lastCapture, captures

def deleteCaptures(capturesDir, captures):
    for capture in captures:
        os.remove(os.path.join(capturesDir, capture))

def main(args):
    if len(args) != 2:
        raise ValueError("Usage: " + args[0] + " capturesDir")

    capturesDir = args[1]
    lastCapture, otherCaptures = getLastCaptureAndOthers(capturesDir)
    if lastCapture:
        deleteCaptures(capturesDir, otherCaptures)
        return os.path.join(capturesDir, lastCapture) + " " + lastCapture.split(".")[CAPTURE_TIME_IN_SECONDS_FIELD]
    else:
        return ""

if __name__ == '__main__':
    print main(sys.argv)
