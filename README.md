VisionDefectSimulation
======================

This project contains the code used to do [vision simulations](http://xscopeapp.com/testing#3) in [xScope](http://xscopeapp.com/). The `VisionDefectSimulation` class creates a Core Image filter which can be used to simulate color blindness and Presbyopia.

A sample project, Retination, is included to show how this filter can be used to modify a `CGImageRef` or `NSImage`. (Look at the `VisionView` class for details.)

The code _does not_ use ARC, as I wanted the code to work in as many different development environments as possible.

It is my hope that by making this code public, more tools will provide designers and developers with the information to make better visual choices.