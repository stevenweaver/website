## Introduction

From its inception in 2005, Datamonkey has been a valuable web resource for
phylogenetic analysis in the life sciences. Well over 500,000 jobs have been
processed since 2010, the computational cluster has increased from 40 processors
to 1024 processors, and the site has been extended multiple times with new
features that include the latest methods developed within the HyPhy package.

However, over the course of the past 10 years, the advances in web
technologies have dramatically changed to help improve user experience, ease
development by recognizing and standardizing design patterns common to web
applications, and to better accomodate long-running job processes and
increasingly larger datasets.

By utilizing the explosive growth of JavaScript this decade, thanks in large
part to the release of the V8 open source JavaScript engine in 2008, we have
been able to take advantage of the advancement in web technologies to bring a
much improved experience with the latest release of Datamonkey. In addition to
an entirely new architecture written in Node.js, Datamonkey has also implemented
new, interactive visualizations with React and d3.js.

## Datamonkey Architecture

Datamonkey's primary function is to allow researchers to conduct comparative
analyses of sequence alignments using statistical models developed in HyPhy via
the web. These analyses can take anywhere from minutes to hours to complete
depending on the type of analysis being conducted and the size of the dataset.

In order to accommodate hundreds of long running jobs daily, the web application
is separated into two separate components (see figure). One component is hosted
on a standard webserver, and performs standard model-view-controller duties.
Responsibilities include hosting html templates, accepting new analysis
requests, providing job status in real-time, serving results, and optionally
emailing users when their job has completed.

The second component is hosted on a high performance computing cluster, and
performs both job provisioning and status reporting to the web application
component via WebSockets. By separating this part of the application into its
own component, we have the option to distribute computationally intensive jobs
across multiple or alternative high performance computing resouces with minimal
configuration chages and disturbance to the component of the application that is
user facing.

### Specific Technologies

#### Node.js, WebSockets, and Redis

The researcher receives updates on their analyses in real-time. In the past and
due to the client-server architecture of the web, real-time could only be
simulated by polling the server at regular intervals. The experience of early
polling applications was inefficient because it required multiple requests to
the server, and was therefore inherently inferior to the experience of running
the job on the machine itself. Datamonkey makes use of the event-driven nature
of Node.js and JavaScript, along with the WebSocket protocol, in order for the
researcher to receive updates on their analysis as soon as they happen.  We
acheived this by utilizing a publish-subscribe pattern.  When the job process
(most commonly HyPhy) writes to standard output, the text is published to a
transient key/value datastore (Redis). A publish event is triggered, and
listening subscribers receive the update immediately.  For browsers using
WebSockets (the most commonly used browsers all have an implementation of the
protocol), the text is received immediately from the server without polling, and
can be displayed or visualized in any defined way by client-side code.

#### d3.js, React, and Webpack

Results visualization is rendered entirely by way of client-side JavaScript.
With the advent of svg and canvas HTML elements being widely supported in the
most commonly used browsers, and subsequent frameworks such as d3 utilizing
those elements being made available, we have been able to develop visualizations
that researchers can immediately interact with in order to facilitate inferences
that can be made from their results.

d3.js 

React, a JavaScript library for building user interfaces, allows

Webpack


### TORQUE Job Scheduler


## Methods Available

### aBSREL

### BUSTED

### FEL

### FUBAR

### GARD

### MEME

### RELAX

### PRIME

More to come...

## Citations and Resources
V8 - https://github.com/v8/v8/wiki
Node.js - https://nodejs.org/en/about/

Datamonkey 2005 - https://pdfs.semanticscholar.org/2f06/20074d4ff4f58329bda434980c0e0a2a1644.pdf
Datamonkey 2010 - https://academic.oup.com/bioinformatics/article/26/19/2455/228720/Datamonkey-2010-a-suite-of-phylogenetic-analysis
HyPhy - https://scholar.google.com/citations?view_op=view_citation&hl=en&user=SP6nj-QAAAAJ&citation_for_view=SP6nj-QAAAAJ:u5HHmVD_uO8C

### Every method 
aBSREL - https://academic.oup.com/mbe/article/32/5/1342/1130440/Less-Is-More-An-Adaptive-Branch-Site-Random
BUSTED - https://academic.oup.com/mbe/article/32/5/1365/1134918/Gene-Wide-Identification-of-Episodic-Selection
FEL, SLAC - https://scholar.google.com/citations?view_op=view_citation&hl=en&user=SP6nj-QAAAAJ&citation_for_view=SP6nj-QAAAAJ:d1gkVwhDpl0C
FUBAR - https://academic.oup.com/mbe/article/30/5/1196/998247/FUBAR-A-Fast-Unconstrained-Bayesian-AppRoximation
GARD - https://scholar.google.com/citations?view_op=view_citation&hl=en&user=SP6nj-QAAAAJ&citation_for_view=SP6nj-QAAAAJ:qjMakFHDy7sC
MEME - http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1002764
RELAX - https://academic.oup.com/mbe/article/32/3/820/981440/RELAX-Detecting-Relaxed-Selection-in-a
PRIME - Supply link

Phylotree.js - https://github.com/veg/phylotree.js
