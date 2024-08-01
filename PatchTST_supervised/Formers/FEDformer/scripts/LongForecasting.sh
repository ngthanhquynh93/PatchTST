# cd FEDformer
if [ ! -d "../logs" ]; then
    mkdir ../logs
fi

if [ ! -d "../logs/LongForecasting" ]; then
    mkdir ../logs/LongForecasting
fi

for preLen in 1
do
# ETTm1
python -u run.py \
  --is_training 1 \
  --root_path /content/PatchTST/PatchTST_supervised/dataset/ \
  --data_path scaled_haichau_1h_rooftop.csv \
  --model FEDformer \
  --data custom \
  --features S \
  --target Active_Power \
  --seq_len 96 \
  --label_len 48 \
  --pred_len $preLen \
  --e_layers 3 \
  --d_layers 2 \
  --factor 1 \
  --enc_in 1 \
  --dec_in 1 \
  --c_out 1 \
  --des 'Exp' \
  --d_model 512 \
  --itr 1  >../logs/LongForecasting/FEDformer_haichau_$pred_len.log
done

# cd ..