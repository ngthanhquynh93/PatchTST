# Run this code in main file colab to execute the model
from google.colab import drive
drive.mount('/content/drive')
!mkdir -p /root/.ssh
# firstly, connect your driver before run the cmd
!cp /content/drive/MyDrive/deploy-keys/id* /root/.ssh/
# create a rsa key
# !ssh-keygen -t rsa -b 4096 -C "ngthanhquynh93@gmail.com" -f ~/.ssh/id_rsa -N ""
# open the key and copy this key to ssh in github account (which is usually done before)
# !cat ~/.ssh/id_rsa.pub
# Add github as known host
!ssh-keyscan -H github.com >> ~/.ssh/known_hosts
!git clone git@github.com:ngthanhquynh93/PatchTST.git
!pip install -r requirements.txt
import sys
if not 'PatchTST' in sys.path:
    sys.path += ['PatchTST/PatchTST_supervised']
!pip install einops
!sh ./scripts/PatchTST/univariate/scaled_haichau_1h_rooftop.sh
import numpy as np
import pandas as pd
from google.colab import files
setting = 'scaled_haichau_1h_rooftop_72_Transformer_custom_ftMS_sl72_ll48_pl72_dm512_nh8_el3_dl2_df2048_fc3_ebtimeF_dtTrue_Exp_0'
true = np.load('./results/'+setting+'/true.npy')
pred = np.load('./results/'+setting+'/pred.npy')
# metric = np.load('./results/'+setting+'/metrics.npy')
# print(metric)

df = pd.DataFrame()
df['y_pred_scale'] = pred[:,:, -1].flatten()
df['y_test_scale'] = true.flatten()

import matplotlib.pyplot as plt
plt.close('all')
plt.figure()
x=range(len(true))
plt.plot(x[:168], np.squeeze(true[:168]),'r')
plt.plot(x[:168], np.squeeze(pred[:168,:,-1]),'g')
plt.show()

df.to_excel('du_lieu_transformer_multivariate_72_72.xlsx', index=True)
files.download('du_lieu_transformer_multivariate_72_72.xlsx')

