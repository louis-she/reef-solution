#!/bin/bash
set -x

for resolution in 1280 1800 2400 3200
do
	python train.py \
		--img $resolution \
		--batch 1 \
		--epochs 13 \
		--data /home/featurize/trainfull/dataset.yaml \
		--bg-ratio 0.0 \
		--weights yolov5l6.pt \
		--project /home/featurize/yolov5 \
		--exist-ok \
		--name fulltrain-r${resolution} \
		--multi-scale \
		--hyp ./configs/default.yaml  \
		--val_scales $resolution  \
		--val_start 12 \
		--seed 666
done
