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
    intel-openvino-runtime-centos7-2020.2.130 \
    intel-openvino-model-optimizer-2020.2.130 \
    intel-openvino-omz-dev-2020.2.130 \
    intel-openvino-omz-tools-2020.2.130 \   
    ffmpeg \
    ffmpeg-devel \
    && yum clean all \
    && sed -i 's/return 0/return 1/g' ${INSTALL_DIR}/install_dependencies/install_openvino_dependencies.sh \
    && ${INSTALL_DIR}/install_dependencies/install_openvino_dependencies.sh -y \
    && pip3 install -r ${INSTALL_DIR}/python/requirements.txt \
    && pip3 install opencv-python \
    && rm -r /root/.cache
ENV GST_PLUGIN_SCANNER=/opt/intel/openvino/data_processing/gstreamer/bin/gstreamer-1.0/gst-plugin-scanner \
    LIBRARY_PATH=/opt/intel/openvino/data_processing/dl_streamer/lib:/opt/intel/openvino/data_processing/gstreamer/lib: \
    LC_NUMERIC=C \
    GST_VAAPI_ALL_DRIVERS=1 \
    HDDL_INSTALL_DIR=/opt/intel/openvino/deployment_tools/inference_engine/external/hddl \
    LD_LIBRARY_PATH=/opt/intel/openvino/data_processing/dl_streamer/lib:/opt/intel/openvino/data_processing/gstreamer/lib:/opt/intel/openvino/opencv/lib:/opt/intel/openvino/deployment_tools/ngraph/lib:/opt/intel/openvino/deployment_tools/inference_engine/external/hddl/lib:/opt/intel/openvino/deployment_tools/inference_engine/external/gna/lib:/opt/intel/openvino/deployment_tools/inference_engine/external/mkltiny_lnx/lib:/opt/intel/openvino/deployment_tools/inference_engine/external/tbb/lib:/opt/intel/openvino/deployment_tools/inference_engine/lib/intel64: \
    PATH=/opt/intel/openvino/deployment_tools/model_optimizer:/opt/intel/openvino/data_processing/gstreamer/bin:/opt/intel/openvino/data_processing/gstreamer/bin/gstreamer-1.0:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    ngraph_DIR=/opt/intel/openvino/deployment_tools/ngraph/cmake \
    InferenceEngine_DIR=/opt/intel/openvino/deployment_tools/inference_engine/share \
    OpenCV_DIR=/opt/intel/openvino/opencv/cmake \
    MODELS_PATH=/root/intel/dl_streamer/models \
    GST_SAMPLES_DIR=/opt/intel/openvino/data_processing/dl_streamer/samples \
    PYTHONPATH=/opt/intel/openvino/python/python3.6:/opt/intel/openvino/python/python3:/opt/intel/openvino/deployment_tools/open_model_zoo/tools/accuracy_checker:/opt/intel/openvino/deployment_tools/model_optimizer:/opt/intel/openvino/data_processing/dl_streamer/python:/opt/intel/openvino/data_processing/gstreamer/lib/python3.6/site-packages: \
    GST_PLUGIN_PATH=/opt/intel/openvino/data_processing/dl_streamer/lib:/opt/intel/openvino/data_processing/gstreamer/lib/gstreamer-1.0 \
    PKG_CONFIG_PATH=/opt/intel/openvino/data_processing/dl_streamer/lib/pkgconfig:/opt/intel/openvino/data_processing/gstreamer/lib/pkgconfig: \
    INTEL_OPENVINO_DIR=/opt/intel/openvino \
    GI_TYPELIB_PATH=/opt/intel/openvino/data_processing/gstreamer/lib/girepository-1.0 \
    INTEL_CVSDK_DIR=/opt/intel/openvino \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8    