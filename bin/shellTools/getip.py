#!/usr/bin/env python

import re,os,sys,subprocess,shlex
from subprocess import PIPE
import shutil
import optparse

DEBUG=False

def info(msg):
    print("[*] %s" % msg)
def debug(msg):
    global DEBUG
    if DEBUG:
        print("[D]: %s" % msg)

def main():
    parser = optparse.OptionParser()
    parser.add_option("--all"
        , action="store_true"
        , dest="all"
        , default=False
        , help="Get all interfaces"
        )
    parser.add_option("--linux"
        , action="store_true"
        , dest="linux"
        , default=False
        , help="do linux ifconfig"
        )
    (opts,args) = parser.parse_args()
    doLinux = False
    if opts.linux:
        doLinux = True

    interface = ""
    ret = subprocess.Popen(shlex.split("ifconfig %s" % interface), stdin=PIPE, stdout=PIPE, stderr=PIPE)
    if doLinux:
        interfaceLine = re.compile(b"^([a-zA-Z0-9_-]+)\W+")
        inetLine = re.compile(b"\W+inet\W+(?:addr:)?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*")
                              #"\W+inet\W+(?:addr:)(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*"
    else:
        interfaceLine = re.compile("^(\w+):")
        inetLine = re.compile(b".*inet (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) netmask .*")
    newInterface = ""
    newInet = ""
    myIp = None
    while True:
        line = ret.stdout.readline()
        if line != b'':
            theInterfaceNow = interfaceLine.match(line)
            if theInterfaceNow:
                newInterface = "%s" % theInterfaceNow.group(1).decode("utf-8")
                debug(newInterface)
            else:
                theInetLine = inetLine.match(line)
                if theInetLine:
                    newInet = theInetLine.group(1).decode("utf-8")
                    debug(newInet)
                    myIp = "(%s:%s)" % (newInterface,newInet)
                    newInterface = ""
                    newInet = ""
            if myIp:
                sys.stdout.write("%s " % myIp)
                myIp = None
                
        else:
            break
    ret.wait()
    if ret.returncode != 0:
        raise Exception("ifconfig fucking failed")

if __name__ == "__main__":
    main()
