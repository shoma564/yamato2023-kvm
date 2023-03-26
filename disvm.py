import discord, os, subprocess, asyncio
from discord.ext import commands
from pathlib import Path
from pathlib import Path

# インテントの生成
intents = discord.Intents.default()
intents.message_content = True

bot = discord.ext.commands.Bot(command_prefix = "!",intents=intents);

# クライアントの生成
#client = discord.Client(intents=intents)

# discordと接続した時に呼ばれる
#@client.event
#async def on_ready():
#    print(f'We have logged in as {client.user}')

# メッセージを受信した時に呼ばれる
#@client.event
#async def on_message(message):
    # 自分のメッセージを無効
#    if message.author == client.user:
#        return

    # メッセージが"$hello"で始まっていたら"Hello!"と応答
#    if message.content.startswith('$hello'):
#        print(f'hello')
#        await message.channel.send('Hello!')



@bot.command()
async def ubuntu(ctx, arg1, arg2):
    await ctx.channel.send(f'ubuntuVMの作成中')
    print(f'VMの作成を開始')
    com = "python3 /home/yamato/image/vm.py " + str(arg1) + " " + str(arg2)
    print(com)
    os.system(com)
    await ctx.channel.send(f'ubuntuを作成しました。ubuntu-{arg1}のipアドレスは10.254.6.{arg1}で、合計{arg2}つのubuntuVMを作成しました。')
    proc = subprocess.run(["virsh", "list", "--all"], capture_output=True, text=True)
    print(proc.stdout)
    com = proc.stdout
    await ctx.channel.send(com)


@bot.command()
async def k8smaster(ctx, arg1):
    await ctx.channel.send(f'K8smasterの作成中')

    path = Path("/home/yamato/kubetoken")
    if path.is_file():
        path.unlink()

    print(f'k8smasterの作成を開始')
    com = "/home/yamato/image/k8sdep.sh " + str(arg1)
    print(com)
    os.system(com)
    await ctx.channel.send(f'k8s-masterを作成しました。k8s-ubuntu-{arg1}のipアドレスは10.254.6.{arg1}です。')

    while True:
        path = '/home/yamato/kubetoken'
        is_file = os.path.isfile(path)
        if is_file:
            with open('/home/yamato/kubetoken') as f:
                file_read = f.read()
            await ctx.channel.send(file_read)
            break
        else:
            pass
        await asyncio.sleep(1)
        print("ファイル待機中")

    proc = subprocess.run(["virsh", "list", "--all"], capture_output=True, text=True)
    print(proc.stdout)
    com = proc.stdout
    await ctx.channel.send(com)



@bot.command()
async def k8sworker(ctx, arg1, arg2, arg3, arg4):
    await ctx.channel.send(f'K8sworkerの作成中')
    print(f'k8sworkerの作成を開始')
    com = "python3 /home/yamato/image/k8swor.py " +"\""+ str(arg1) +"\"" + " "+"\""+ str(arg2) +"\"" + " "+"\""+ str(arg3) +"\"" + " "+"\""+ str(arg4) +"\""
 
    print(com)
    os.system(com)
    await ctx.channel.send(f'k8s-workerを作成しました。k8s-worker-{arg1}のipアドレスは10.254.6.{arg1}です。')
    proc = subprocess.run(["virsh", "list", "--all"], capture_output=True, text=True)
    print(proc.stdout)
    com = proc.stdout
    await ctx.channel.send(com)




@bot.command()
async def ubuntudel(ctx, arg1, arg2):
    await ctx.channel.send(f'ubuntuVMの削除中')
    com = "/home/yamato/image/delvm.sh " + str(arg1) + " " + str(arg2)
    print(com)
    os.system(com)
    await ctx.channel.send(f'ubuntuを削除しました。ubuntu-{arg1}のipアドレスは10.254.6.{arg1}で、合計{arg2}つのubuntuVMを削除しました')
    proc = subprocess.run(["virsh", "list", "--all"], capture_output=True, text=True)
    print(proc.stdout)
    com = proc.stdout
    await ctx.channel.send(com)



@bot.command()
async def vmlist(ctx):
    await ctx.channel.send(f'VMのリストを取得します。')
    proc = subprocess.run(["virsh", "list", "--all"], capture_output=True, text=True)
    print(proc.stdout)
    com = proc.stdout
    await ctx.channel.send(com)


@bot.command()
async def commandlist(ctx):
    await ctx.channel.send(f'commandのリストを取得します。')
    com = "ubuntuVMの作成    !ubuntu \"第４オクテッド\" \"VMの個数\" \nubuntuVMの削除    !ubuntudel \"第４オクテッド\" \"VMの個数\" \nVMlistの取得    !vmlist\nk8smasterの作成    !k8smaster \"第４オクテッド\" \nk8sworkerの作成    !k8sworker \"第４オクテッド\" \"VMの個数\" \"MasterのIP\" \"--token以下\" \nVMの起動    !vmstart \"第４オクテッド\" \"VMの個数\" \nVMの停止    !vmstop \"第４オクテッド\" \"VMの個数\" \n"
    await ctx.channel.send(com)



# クライアントの実行
#client.run('MTA4Njk0OTQxNTAyMzAzMDM0NA.GQORqB.aYmqEezIjvVOsPsD0Ja0cPQn_Q8YSNKqQUjxXk')
bot.run("MTA4Njk0OTQxNTAyMzAzMDM0NA.GWfOJD.988fXCPMT_Ey2R7ejaWA8kPS0E5HEGG6Leg_9Y")
