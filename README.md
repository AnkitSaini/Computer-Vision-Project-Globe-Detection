# Computer-Vision-Project-Globe-Detection
Political globe detection in a cluttered environment

The common problem in computer vision is to search and find specific objects or shapes in a picture or video stream. In this particular project we were asked to design and implement a complete procedure that can identify the small political globe, in any orientation and a cluttered environment, either by selecting available tools or by writing our own code. 

To run the algorithm, open file 'globe.m' in Matlab. It uses files Hough Circles, DiscardDuplicateCircles, DiscardInnerCircles, DiscardNonEnclosedCircles to find cirlces in the image. The cirlces which are contained completely in another circle are discarded. Also circles which do not lie entirely in the image are also discarded. After the initial processing and finding circles using Hough Transform, we detect the squares formed by the latitudes and longitudes to detect our globe. The files HoughLines, SeparateHorVerLines, DiscardDuplicateLines, DiscardNonHorVerLines, FindSquares are used to find the squares in the image. 

Detailed information about the project can be found at - https://goo.gl/fl1NFO
.

