# Dotfiles (WIP)
Hey stranger! If you randomly stumbled upon my dotfiles I want to say "Congrats to you!" but you might want to check this repository at a out at a later point in time as they're still heavily under construction.

## Table of contents
* [Introduction](#introduction)
* [Installation](#installation)
* [Setting up a Repository](#setting-up-a-repository)
* [Restoring Configurations](#restoring-configurations)

## Introduction
This repository contains my personal configuration files (aka. *dotfiles*).

In the following sections I'll explain how this dotfiles repository works, how to use it, how to restore it & how to setup your own.

## Installation
The project provides two ways for setup by either running the *install.sh* for just setting copying the configurations or the *script/install_hw.sh* which is targeted at setting up a complete machine from scratch in a live environment (i.e. the official [Arch Linux ISO](https://www.archlinux.org/download/).

### install.sh
- Installs dotfiles.
- Backups already present dotfiles, which would be overwritten.

### scripts/deploy.sh
- IS DESTRUCTIVE! Use at your own risk.
- Setups a complete new hardware machine with dotfiles.
- Parameters can be configured in the script.

## Setting up a Repository
There are countless ways to setup your own dotfiles. For the start you could have a look at the dotfiles guide of GitHub: https://dotfiles.github.io/

I personally prefer to use a bare git repository for managing my dotfiles: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
If you would like to use the included scripts for your own intents and purposes I would advise you to use the same approach.

## Licenses
This files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.
