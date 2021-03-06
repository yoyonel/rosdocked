# FROM ros:indigo
FROM ros:lunar

# Arguments
ARG user
ARG uid
ARG home
ARG workspace
ARG shell

# CMake 3.x
RUn apt-get update
RUN apt-get -y remove cmake cmake-data
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x && apt-get update
RUN apt-get -y install cmake

# Basic Utilities
RUN apt-get -y update && \
    apt-get install -y \
      zsh \
      tree \
      sudo \
      ssh \
      synaptic \
      mosh

# Latest X11 / mesa GL
# RUN apt-get install -y\
#   xserver-xorg-dev-lts-wily\
#   libegl1-mesa-dev-lts-wily\
#   libgl1-mesa-dev-lts-wily\
#   libgbm-dev-lts-wily\
#   mesa-common-dev-lts-wily\
#   libgles2-mesa-lts-wily\
#   libwayland-egl1-mesa-lts-wily\
#   libopenvg1-mesa

# Dependencies required to build rviz
# RUN apt-get install -y\
#   qt4-dev-tools\
#   libqt5core5a libqt5dbus5 libqt5gui5 libwayland-client0\
#   libwayland-server0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1\
#   libxcb-render-util0 libxcb-util0 libxcb-xkb1 libxkbcommon-x11-0\
#   libxkbcommon0

# The rest of ROS-desktop
# RUN apt-get install -y ros-indigo-desktop-full

# Additional development tools
RUN apt-get install -y \
      x11-apps \
      python-pip \
      build-essential
RUN pip install catkin_tools

# Add packages
RUN apt-get install -y\
    bash-completion \
    realpath

# TMux (last release from sources)
RUN apt-get install -y automake libevent-dev ncurses-dev
RUN git clone https://github.com/tmux/tmux.git /tmp/tmux
WORKDIR /tmp/tmux
RUN sh autogen.sh && ./configure
RUN make install -j
RUN rm -rf /tmp/tmux

# Make SSH available
EXPOSE 22

# Mount the user's home directory
VOLUME "${home}"

# Clone user into docker image and set up X11 sharing 
RUN \
  echo "${user}:x:${uid}:${uid}:${user},,,:${home}:${shell}" >> /etc/passwd && \
  echo "${user}:x:${uid}:" >> /etc/group && \
  echo "${user} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${user}" && \
  chmod 0440 "/etc/sudoers.d/${user}"

# Switch to user
USER "${user}"
# This is required for sharing Xauthority
ENV QT_X11_NO_MITSHM=1
ENV CATKIN_TOPLEVEL_WS="${workspace}/devel"
# Switch to the workspace
WORKDIR ${home}
