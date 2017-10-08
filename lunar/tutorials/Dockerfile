FROM ros:lunar-ros-base

# install ros tutorials packages
RUN apt-get update && \
	apt-get install -y \
    	ros-lunar-ros-tutorials \
    	ros-lunar-common-tutorials \
    	&& rm -rf /var/lib/apt/lists/