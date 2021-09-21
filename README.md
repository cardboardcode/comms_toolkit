## **What Is This?** 
This repository contains a general toolkit one can use to navigate quickly on a new Ubuntu laptop.

## **Setup** :hammer:

Run the commands below to download and set up the bash command toolkit on your workstation to quickly start using.

```bash
cd $HOME
git clone https://github.com/cardboardcode/comms_toolkit.git --depth 1 --single-branch
```

```bash
echo "source ~/comms_toolkit/comms_set.bash" >> ~/.bashrc
source ~/.bashrc
``` 

## **TODO**
- [ ] Implement a modular feature that prints out description of toolkit commands while adhering to DRY principle.
