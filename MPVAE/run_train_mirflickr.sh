python train.py \
    --data_dir ./data/mirflickr/mirflickr_data.npy \
    --train_idx ./data/mirflickr/mirflickr_train_idx.npy \
    --valid_idx ./data/mirflickr/mirflickr_val_idx.npy \
    --test_idx ./data/mirflickr/mirflickr_test_idx.npy \
    --learning_rate 0.00075 \
    --max_epoch 300 \
    --meta_offset 0 \
    --label_dim 38 \
    --z_dim 38 \
    --feat_dim 1000 \
    --model_dir model/model_mirflickr/ \
    --summary_dir summary/summary_mirflickr/ \
    --visual_dir visualization/visualization_mirflickr/ \
    --nll_coeff 0.1 \
    --l2_coeff 1.0 \
    --c_coeff 200. \
    --batch_size 128 \
    --test_sh_path ./run_test_mirflickr.sh \
    --write_to_test_sh True \
    --dataname mirflickr \
    --lr_decay_ratio 0.5 \
    --lr_decay_times 4. \
    --check_freq 40 \
    --keep_prob 0.5
