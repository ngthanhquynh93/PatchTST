# ALL scripts in this file come from Autoformer
if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

random_seed=2021
model_name=Transformer
pred_len=1

for model_name in Autoformer Informer Transformer
do
for seq_len in 24 72 168 336 720
do
  python -u run_longExp.py \
    --random_seed $random_seed \
    --is_training 1 \
    --root_path ./dataset/ \
    --data_path scaled_haichau_1h_rooftop.csv \
    --model_id scaled_haichau_1h_rooftop_$pred_len \
    --model $model_name \
    --data custom \
    --features S \
    --target Active_Power \
    --seq_len $seq_len \
    --label_len 12 \
    --pred_len $pred_len \
    --e_layers 3 \
    --d_layers 2 \
    --factor 1 \
    --enc_in 1 \
    --dec_in 1 \
    --c_out 1 \
    --des 'Exp' \
    --itr 1 \
    --train_epochs 20 >logs/LongForecasting/$model_name'_rooftop_'$pred_len.log

  done
done
