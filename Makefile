# export ARCH=`uname -m`
# Currently the image does not support arm64, 
# We have to hard code the arch into amd64 as a workaround
export ARCH=amd64
export VER=0.1
export IMAGE_NAME=`cd install && ls petalinux-v*-installer.run`
export PWD=`pwd`
export EXTRA_BUILD_FLAG=

image:
	make image-${ARCH}

image-arm64:
	docker build -f docker/dockerfile -t fangruil/petalinux-dev:${IMAGE_NAME}-arm64 -t fangruil/petalinux-dev:${IMAGE_NAME}-arm64-${VER} --platform linux/arm64  --build-arg PETALINUX_INSTALLER=${IMAGE_NAME} ${EXTRA_BUILD_FLAG} .

image-x86_64:
	make image-amd64

image-amd64:
	docker build -f docker/dockerfile -t fangruil/petalinux-dev:${IMAGE_NAME}-amd64 -t fangruil/petalinux-dev:${IMAGE_NAME}-amd64-${VER} --platform linux/amd64 --build-arg PETALINUX_INSTALLER=${IMAGE_NAME} ${EXTRA_BUILD_FLAG} .

container:
	echo ${ARCH};
	if [ ${ARCH} = "arm64" ]; then docker run --rm -it -v ${PWD}:/workspace/project fangruil/petalinux-dev:${IMAGE_NAME}-arm64 bash; else docker run --rm -it -v ${PWD}:/workspace/project/ fangruil/petalinux-dev:${IMAGE_NAME}-amd64 bash; fi

push:
	make push-image-${ARCH}

push-x86_64:
	make push-image-amd64

push-image-amd64:
	docker push fangruil/petalinux-dev:${IMAGE_NAME}-amd64 
	docker push fangruil/petalinux-dev:${IMAGE_NAME}-amd64-${VER}

push-image-arm64:
	docker push fangruil/petalinux-dev:${IMAGE_NAME}-arm64 
	docker push fangruil/petalinux-dev:${IMAGE_NAME}-arm64-${VER}