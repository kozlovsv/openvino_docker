FROM centos:7
ARG INSTALL_DIR=/opt/intel/openvino
RUN yum update -y \
    && yum install -y \
    yum-utils \
    epel-release \
    && yum-config-manager --add-repo https://yum.repos.intel.com/openvino/2020/setup/intel-openvino-2020.repo \
    && rpm --import https://yum.repos.intel.com/openvino/2020/setup/RPM-GPG-KEY-INTEL-OPENVINO-2020 \
    && rpm -v --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro \
    && rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm \
    && yum install -y \
    mc \
    intel-openvino-runtime-centos7 \
    intel-openvino-model-optimizer \
    intel-openvino-omz-dev \
    intel-openvino-omz-tools \   
    ffmpeg \
    ffmpeg-devel \
    && yum clean all \
    && sed -i 's/return 0/return 1/g' ${INSTALL_DIR}/install_dependencies/install_openvino_dependencies.sh \
    && ${INSTALL_DIR}/install_dependencies/install_openvino_dependencies.sh -y \
    && pip3 install -r ${INSTALL_DIR}/python/requirements.txt \
    && pip3 install opencv-python \
    && echo "source ${INSTALL_DIR}/bin/setupvars.sh" >> /root/.bashrc \
    && rm -r /root/.cache
