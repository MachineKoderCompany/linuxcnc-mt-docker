#!/bin/bash -e

# add hostname to hosts
sh -c 'echo "127.0.2.1  `hostname`" >> /etc/hosts'

# Add user and group to system
echo "${USER}:x:${UID}:${GID}::${HOME}:/bin/bash" >>/etc/passwd
echo "${USER}:x:${GID}:" >>/etc/group
echo "${USER}:*:17840:0:99999:7:::" >> /etc/shadow
sed -i '/.*sudo.*:/ s/$/'${USER}'/' /etc/group
sed -i '/.*audio.*:/ s/$/,'${USER}'/' /etc/group
sed -i '/.*pulse.*:/ s/$/,'${USER}'/' /etc/group
sed -i '/.*pulse-access.*:/ s/$/,'${USER}'/' /etc/group

# source ROS
# echo -e " if [ -z \"\$ROS_INIT\" ];then
#   export ROS_DISTRO=
#   source /opt/ros/melodic/setup.bash
#   export ROS_DISTRO=
#   source /opt/ros/dashing/setup.bash
#   echo 'ROS1/ROS2 ready to use'
#   export ROS_INIT=1
# fi
# " >> /etc/profile.d/ros_activate.sh
export ROS_IP=127.0.0.1
export ROS_MASTER_URI=http://127.0.0.1:11311

# remove .dockerenv to make Mycroft start work
rm /.dockerenv

# Run command as user
default_cmd=(/bin/bash --login -i)
exec sudo -u ${USER} -E "${@:-${default_cmd[@]}}"
