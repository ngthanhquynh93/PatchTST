# ALL scripts in this file come from Autoformer
if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

random_seed=42
root_path_name=./dataset/
data_path_name=scaled_haichau_1h_rooftop.csv
model_id_name=scaled_haichau_1h_rooftop
data_name=custom
target=Active_Power
seq_len=96

for model_name in Autoformer Informer Transformer
do 
for pred_len in 1 24 48 72
do
  python -u run_longExp.py \
    --random_seed $random_seed \
    --is_training 1 \
    --root_path $root_path_name \
    --data_path $data_path_name \
    --model_id $model_id_name'_'$pred_len \
    --model $model_name \
    --data $data_name \
    --features S \
    --target $target \
    --seq_len $seq_len \
    --label_len 1 \
    --pred_len $pred_len \
    --e_layers 3 \
    --d_layers 2 \
    --factor 1 \
    --enc_in 1 \
    --dec_in 1 \
    --c_out 1 \
    --des 'Exp' \
    --train_epochs 10 \
    --itr 1 >logs/LongForecasting/$model_name'_rooftop_'$pred_len.log
done
done
