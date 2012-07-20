TideSDK-Nightly
===============

Website for displaying nightly builds available from most recent development

To run this project, there must be a subdirectory in the root directory of this app with the following structure.

builds/
-- osx-x86-64/
-- ubuntu-x86-64/
-- ubuntu-x86/
-- fedora-x86-64/
-- fedora-x86/
-- win-x86-64/
-- win-x86/

Inside of each OS directory, there should be files titled in the following manner.

TideSDK-1.2.1.RC1-2f3a782a-osx-10.6.8-x86-64.zip

This project was built in Ruby on the Camping Microframework

To install it, gem install camping

To run it, camping build.rb
