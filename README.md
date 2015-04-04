### Overview

This script converts an XML file from a Maja RFID reader to a CSV file.

### Requirements
you must have ruby installed on your machine.

### Installation
1. run `gem install bundler` from the commandline
1. run `bundle` to install dependencies

### Usage
* run `convert_xml_to_csv.rb <input_filename>`
* the input file must be an XML file
* this will generate an output CSV file with the same name as the input XML file but with a `.csv` extension
