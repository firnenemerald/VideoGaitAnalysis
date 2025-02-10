# SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr>
# SPDX-License-Identifier: GPL-3.0-or-later

import pandas as pd
import re

# Load the data
datafile_path = 'C:/Users/chanh/Downloads/aPDcog.xlsx'
pid = 51936835

df = pd.read_excel(datafile_path)
filtered_df = df[df['PID'] == pid]
npt_data = filtered_df['NPT'].tolist()[0]
npt_text = npt_data.replace('\n', ' ').replace('\t', ' ')

# Define the exam parts
parts = ['주의력', '언어', '기억력', '감각-운동 조정', '전두엽성 기능']

# Make a dictionary to hold the segmented text
segmented_text = {segment: '' for segment in parts}
for i, segment in enumerate(parts):
    if i < len(parts) - 1:
        start_index = npt_text.find(segment) + len(parts[i])
        end_index = npt_text.find(parts[i + 1])
        segmented_text[segment] = npt_text[start_index:end_index].strip()
    else:
        start_index = npt_text.find(segment) + len(parts[i])
        segmented_text[segment] = npt_text[start_index:].strip()
    
print("Parsing data...\n")

# Print the segmented text
# for segment in parts:
#     print(segment + ':')
#     print(segmented_text[segment])
#     print('\n')

# Get '주의력' segment text
attention_text = segmented_text['주의력']
import Subp_attention
Subp_attention.Subp_attention(attention_text)

# Get '언어' segment text
language_text = segmented_text['언어']
import Subp_language
Subp_language.Subp_language(language_text)

# Get '기억력' segment text
memory_text = segmented_text['기억력']
import Subp_memory
Subp_memory.Subp_memory(memory_text)

# Get '감각-운동 조정' segment text
sensorimotor_text = segmented_text['감각-운동 조정']
import Subp_sensorimotor
Subp_sensorimotor.Subp_sensorimotor(sensorimotor_text)

# Get '전두엽성 기능' segment text
frontallobe_text = segmented_text['전두엽성 기능']
import Subp_frontallobe
Subp_frontallobe.Subp_frontallobe(frontallobe_text)

