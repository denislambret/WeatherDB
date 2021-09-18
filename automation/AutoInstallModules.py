import os

modulesList = {}

def loadModulesList(myFileList):
    return True


for item in modulesList:
    
    try:
        import item
    except ImportError:
        print("Trying to Install required module: {}\n".format(item))
        os.system('python -m pip install {}'.format(item))
    # -- above lines try to install requests module if not present
    # -- if all went well, import required module again ( for global access)
