# RPN-Calculator
This is a command line calculator which computes Reverse Polish Notation (RPN) expressions.

This project contains two files:
  * **calculator.rb**, which contains the calculator class and a small calculatorIO class interact between the termial and the calculator
  * **calculator_spec.rb**, which contains the rspec file meant to document and test the various capabilites of the calculator class.
     
     
## How to use

The calculator is run through any ruby enabled terminal or command line. Simply navigate to the calculator.rb file and use the command:

ruby calculator.rb

From there you should be able to input any expresssion given in RPN notation and get an appropriate output in return


To view the spec documentation and rerun the test, be sure you have the rspec version 3.6 gem installed and use the following command:

rspec --format documentation calculator_spec.rb


## References

I used the following references for this project

* https://www.anchor.com.au/wp-content/uploads/rspec_cheatsheet_attributed.pdf

Used to reference rspec syntax

* http://rubylearning.com/satishtalim/ruby_exceptions.html

Used to reference different types of ruby exceptions at how to properly use them

* http://ascii-table.com/info.php?u=x0004

Needed to find an ascii notation for the end-of-transmission character
