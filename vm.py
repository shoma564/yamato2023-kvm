import os,sys,time

args = sys.argv

ip1 = args[1]
ip = int(ip1)

num1 = args[2]
num = int(num1)

while num > 0:

    com = "/home/yamato/image/dep.sh " + str(ip)
    os.system(com)
    ip = ip + 1
    num = num - 1
    time.sleep(5)

print("VM作成完了")
