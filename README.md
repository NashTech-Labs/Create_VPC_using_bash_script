# Create_VPC_using_bash_script

This repository contains scripts that creates AWS VPC using AWS CLI in AWS Cloud.



-------------

**Files:** 
```
      1. VPC.sh
```

## How to run the above scripts

1. First configure the aws credentials on whatever machine you want to run the script by running the below command.

    The profile name in the below configuration will be used in the script and the region should be same wherever the instance is running

    ```
    aws configure
    ```

2. Now, from the current directory run the following command according to your need. Please update your global variables before use.

    ```
    # To run the script, type following command in the terminal
      ./VPC.sh
    ```