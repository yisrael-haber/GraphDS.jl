# GraphDS.jl

## Common Problems
- There seems to be a lack of a simple-interfaced engine that can easily and efficiently generate datasets of graphs. This is important for testing algorithms on a wide collection of graphs tailored to the specification of the researcher (up to a reasonable point.) 
- There is also a need for clear and transparent Dataset generation for the purpose of ML algorithms on graphs such as anomaly detection problems. This lack of clarity causes many issues, including but not limited to unclear code/purposely chosen collections of graphs in a malicious manner. 

## Purpose of the Package
Both of these needs inspired the following Julia package. The first component of this module is the engine for generating the graph dataset according to a valid chosen generator, as determined by the 'Graphs.jl' package, and the specified number of graphs to be generated. The next component deals with the generating a well-suited API to deal with the dataset of graphs. 
Lastly, the final additional component for now deals with io related to these datasets - supplying custom serialization/deserialization of the dataset of graphs to/from a gzipped file string. All together these give solutions to managably small problems that deal with graph datasets. 

## Anomaly Detection
As stated in the second issue above, there is a lack in libraries that support datasets regarding dealing with anomaly detection in graphs. One of these issues comes from the fact that anomalies, as the name suggest, need to be generated. This means that we first need a dataset of "standard" graphs that don't have clear anomalies, you then need to have a method of injecting these anomalies into your graphs - and you need to document these changes in a controlled manner. The basis for supplying an API for this is in this package, and will most likely be a significant part of the future of this package. 

## Installation
Currently the package is not officially registered with the Julia organization and therefore cannot be installed directly with the name of the package. Instead you would first type "]" in the Julia terminal and enter into the console

```console
pkg> add https://github.com/yisrael-haber/GraphDS.jl
```

It will install the package and all of it's dependencies accordingly. 

# TODO:

    - Add more detailed documentation and examples. '''THIS IS ESSENTIAL'''

    - Figure what the hell the schemas should be, and make everything else work with it in a nice well-synchronized 
    fashion. '''THIS IS MOSTLY SOLVED. STILL NEED TO THINK OF SCHEMA FOR ANOMALIES - WILL DECIDE ON THIS LATER.'''

    - Add important 'Base.' operations to the module to create a friendlier and more usable interface.
