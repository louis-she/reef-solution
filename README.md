# 2nd Solution of TensorFlow - Help Protect the Great Barrier Reef

![header](/assets/header.png)

This repo contains the training source code of 2nd solution of Kaggle Competition [TensorFlow - Help Protect the Great Barrier Reef](https://www.kaggle.com/c/tensorflow-great-barrier-reef/overview), inference code can be found at this [Kaggle public notebook](https://www.kaggle.com/snaker/yolo-ensemle?scriptVersionId=87785527). Training code is modified directly on [YOLOv5](https://github.com/ultralytics/yolov5), so it may not be well organized.

## Requirements

* Python 3.7+
* PyTorch==1.9.1+cu111
* [YOLOv5](https://github.com/ultralytics/yolov5) (already in this repo)

## See what's changed from YOLOv5

Using the following command can see the code changed from original YOLOv5.

```
git diff db6ec66 -- ':!README.md'
```

## How to train it


1. **Generate COCO like dataset.**

Open `coco.ipynb` and change second cell to adapt your need.

```python
# root path of reef dataset
reef_dataset_root = "/home/featurize/data"

full_df = pd.read_csv(f"{reef_dataset_root}/train.csv")

# folowing will generate dataset for full dataset training, if you want to do experiment
# you should change the train_df and val_df to the correct part of the data.
# we suggest that using video_id to split the dataset for experiments.
dest_dir = "/home/featurize/full"
train_df = full_df.loc[(full_df.annotations != '[]')]
val_df = full_df.loc[(full_df.video_id == 0) & (full_df.annotations != '[]')]
test_df = val_df
```

2. **Start to train**

The following command will train 4 models with resolutions 1280, 1800, 2400, 3200. Please note you should change the 'relative path' arguments.

The final 3200 resolution can only be trained with single 48G ram GPU (like A6000), from our experiments, 3200 resolution just has a slightly bootst than 2400. The 2400 resolution training is solid enough, so you can remove the 3200 resolution if you do not have the resources.

```bash
bash run.sh
```

The total training will take about 30 hours, if remove 3200 resolution, it'll be about 15 hours.
