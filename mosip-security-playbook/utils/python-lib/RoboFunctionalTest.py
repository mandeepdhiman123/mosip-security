import os
import time
import subprocess
from robot.api import logger


class RoboFunctionalTest(object):
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        """
        Functional Test Library can be imported with below argument
        Arguments:
            - ``module``: Name of the module which need to be run for testing like prereg, admin, regproc
            - ``envuser``: This is the owner of the functional tests. like qa or dev.
            - ``endpoint``: This is the base url of the application.
            - ``testlevel``: this is the lvel of testing you want to run like smoke or regression or both
        Examples:
        | = Keyword Definition =  | = Description =  |
        | Library `|` RoboFunctionalTest  | module | envuser | endpoint | testlevel | port


        self.module = module
        self.envuser = envuser
        self.endpoint = endpoint
        self.testlevel = testlevel
        self.host = host
        self.port = port
        """
    def start_functional_test(self, path, module, envuser, endpoint, testlevel, host, port):
        """
        Start Functional test
        Examples:
        | start functional test  | path | host | port |
        """
        try:
            cmd = 'cd '+ path+ ' && java -jar -Dmodules='+module+' -Denv.user='+envuser+' -Denv.endpoint='+endpoint+' -Denv.testLevel='+testlevel+' -Dhttps.proxyHost='+host+' -Dhttps.proxyPort='+port+' -Dhttp.proxyHost='+host+' -Dhttp.proxyPort='+port+' automationtests.jar'
            os.popen(cmd)
            time.sleep(60)
            pid = 'jcmd | grep automationtests | cut -d " " -f 1'
            status = subprocess.Popen(pid)
            while status != "" or status.isspace()==False:
                logger.info("Test Rig is in progress")
                time.sleep(60)
        except IOError as e:
            logger.info("Please check the options")
