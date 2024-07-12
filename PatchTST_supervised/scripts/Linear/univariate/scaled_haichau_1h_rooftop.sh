if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

if [ ! -d "./logs/LongForecasting/univariate" ]; then
    mkdir ./logs/LongForecasting/univariate
fi
model_name=DLinear
root_path_name=./dataset/
data_path_name=scaled_haichau_1h_rooftop.csv
model_id_name=scaled_haichau_1h_rooftop
data_name=custom
target=Active_Power
seq_len=96
pred_len=1

# ETTh1, univariate results, pred_len= 24 48 96 192 336 720
python -u run_longExp.py \
  --is_training 1 \
  --root_path $root_path_name \
  --data_path $data_path_name \
  --model_id $model_id_name'_'$pred_len \
  --model $model_name \
  --data $data_name \
  --target $target \
  --seq_len $seq_len \
  --pred_len $pred_len \
  --enc_in 1 \
  --des 'Exp' \
  --itr 1 --batch_size 64 --feature S --learning_rate 0.005 >logs/LongForecasting/$model_name'_'fS$model_id_name'_'$pred_len.log
