# SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr>
# SPDX-License-Identifier: GPL-3.0-or-later

import pandas as pd
import re

import Subp_attention, Subp_language, Subp_memory, Subp_sensorimotor, Subp_frontallobe

# Load the data and result file
df = pd.read_excel('C:/Users/chanh/Downloads/aPDcog.xlsx')
dr = pd.read_excel('C:/Users/chanh/Downloads/aPD_cognition_result.xlsx')

# Define the exam parts
parts = ['주의력', '언어', '기억력', '감각-운동 조정', '전두엽성 기능']

# Loop through patient IDs and save the results
for pid in dr['PID']:
    rowNum = dr['PID'] == pid

    filtered_df = df[df['PID'] == pid]
    npt_data = filtered_df['NPT'].tolist()[0]
    npt_text = npt_data.replace('\n', ' ').replace('\t', ' ')

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
    
    print("Parsing data for pid = ", pid)

    # Print the segmented text
    # for segment in parts:
    #     print(f"[{segment}]")
    #     print(segmented_text[segment])
    #     print("******************************")

    # Get '주의력' segment text
    attention_text = segmented_text['주의력']
    [part_a_time, part_a_error, part_b_time, part_b_error, part_c_time, part_c_error] = Subp_attention.Subp_attention(attention_text)

    # print("[주의력] Trail Making Test (TMT)")
    # print("> Part A: 시간", part_a_time, "초, 오류수", part_a_error, "개")
    # print("> Part B: 시간", part_b_time, "초, 오류수", part_b_error, "개")
    # print("> Part C: 시간", part_c_time, "초, 오류수", part_c_error, "개")
    # print("==============================")

    # Get '언어' segment text
    language_text = segmented_text['언어']
    [language_score] = Subp_language.Subp_language(language_text)

    # print("[언어] Korean Boston Naming Test (KBNT)")
    # print("> 점수:", language_score)
    # print("==============================")

    # Get '기억력' segment text
    memory_text = segmented_text['기억력']
    [trial_scores, ka_delayed_recall, ka_delayed_recogn, kc_drawing, kc_immediate_recall, kc_delayed_recall, mq_score] = Subp_memory.Subp_memory(memory_text)

    # print("[기억력] Linguistic & Non-linguistic Memory Test")
    # for i, score in enumerate(trial_scores):
    #         print(f"K-A 시행 {i+1}: {score}")
    # print(f"K-A 지연회상: {ka_delayed_recall}")
    # print(f"K-A 지연재인: {ka_delayed_recogn}")
    # print(f"K-C 그리기: {kc_drawing}")
    # print(f"K-C 즉시회상: {kc_immediate_recall}")
    # print(f"K-C 지연회상: {kc_delayed_recall}")
    # print(f"MQ score: {mq_score}", "점")
    # print("==============================")

    # Get '감각-운동 조정' segment text
    sensorimotor_text = segmented_text['감각-운동 조정']
    [sensorimotor_L_time, sensorimotor_L_error, sensorimotor_R_time, sensorimotor_R_error] = Subp_sensorimotor.Subp_sensorimotor(sensorimotor_text)

    # print("[감각-운동 조정] Grooved Pegboard Test")
    # print("> 왼손: 시간", sensorimotor_L_time, "초, 오류수", sensorimotor_L_error, "개")
    # print("> 오른손: 시간", sensorimotor_R_time, "초, 오류수", sensorimotor_R_error, "개")
    # print("==============================")

    # Get '전두엽성 기능' segment text
    frontallobe_text = segmented_text['전두엽성 기능']
    [stroop_simple_score, stroop_simple_time, stroop_simple_error, stroop_middle_score, stroop_middle_time, stroop_middle_error, stroop_interfere_score, stroop_interfere_time, stroop_interfere_error, fluency_total_score, fluency_s_score, fluency_g_score, fluency_animal_score, fluency_food_score] = Subp_frontallobe.Subp_frontallobe(frontallobe_text)

    # print("[전두엽성 기능] Stroop Test & Word Fluency Test")
    # print("> Stroop 단순시행: 환산점수", stroop_simple_score, "점, 시간", stroop_simple_time, "초, 오류수", stroop_simple_error, "개")
    # print("> Stroop 중간시행: 환산점수", stroop_middle_score, "점, 시간", stroop_middle_time, "초, 오류수", stroop_middle_error, "개")
    # print("> Stroop 간섭시행: 환산점수", stroop_interfere_score, "점, 시간", stroop_interfere_time, "초, 오류수", stroop_interfere_error, "개")
    # print("> Word Fluency 환산점수: ", fluency_total_score, "점")
    # print("> Word Fluency 'ㅅ' 단어: ", fluency_s_score, "개")
    # print("> Word Fluency 'ㄱ' 단어: ", fluency_g_score, "개")
    # print("> Word Fluency 동물 분류: ", fluency_animal_score, "개")
    # print("> Word Fluency 음식 분류: ", fluency_food_score, "개")
    # print("==============================")

    # Save the results to the result file
    dr.loc[rowNum, 'Part A Time'] = part_a_time
    dr.loc[rowNum, 'Part A Error'] = part_a_error
    dr.loc[rowNum, 'Part B Time'] = part_b_time
    dr.loc[rowNum, 'Part B Error'] = part_b_error
    dr.loc[rowNum, 'Part C Time'] = part_c_time
    dr.loc[rowNum, 'Part C Error'] = part_c_error
    dr.loc[rowNum, 'Language Score'] = language_score
    dr.loc[rowNum, 'K-A Trial 1'] = trial_scores[0]
    dr.loc[rowNum, 'K-A Trial 2'] = trial_scores[1]
    dr.loc[rowNum, 'K-A Trial 3'] = trial_scores[2]
    dr.loc[rowNum, 'K-A Trial 4'] = trial_scores[3]
    dr.loc[rowNum, 'K-A Trial 5'] = trial_scores[4]
    dr.loc[rowNum, 'K-A Delayed Recall'] = ka_delayed_recall
    dr.loc[rowNum, 'K-A Delayed Recogn'] = ka_delayed_recogn
    dr.loc[rowNum, 'K-C Drawing'] = kc_drawing
    dr.loc[rowNum, 'K-C Immediate Recall'] = kc_immediate_recall
    dr.loc[rowNum, 'K-C Delayed Recall'] = kc_delayed_recall
    dr.loc[rowNum, 'MQ Score'] = mq_score
    dr.loc[rowNum, 'Sensorimotor L Time'] = sensorimotor_L_time
    dr.loc[rowNum, 'Sensorimotor L Error'] = sensorimotor_L_error
    dr.loc[rowNum, 'Sensorimotor R Time'] = sensorimotor_R_time
    dr.loc[rowNum, 'Sensorimotor R Error'] = sensorimotor_R_error
    dr.loc[rowNum, 'Stroop Simple Score'] = stroop_simple_score
    dr.loc[rowNum, 'Stroop Simple Time'] = stroop_simple_time
    dr.loc[rowNum, 'Stroop Simple Error'] = stroop_simple_error
    dr.loc[rowNum, 'Stroop Middle Score'] = stroop_middle_score
    dr.loc[rowNum, 'Stroop Middle Time'] = stroop_middle_time
    dr.loc[rowNum, 'Stroop Middle Error'] = stroop_middle_error
    dr.loc[rowNum, 'Stroop Interfere Score'] = stroop_interfere_score
    dr.loc[rowNum, 'Stroop Interfere Time'] = stroop_interfere_time
    dr.loc[rowNum, 'Stroop Interfere Error'] = stroop_interfere_error
    dr.loc[rowNum, 'Fluency Total Score'] = fluency_total_score
    dr.loc[rowNum, 'Fluency S Score'] = fluency_s_score
    dr.loc[rowNum, 'Fluency G Score'] = fluency_g_score
    dr.loc[rowNum, 'Fluency Animal Score'] = fluency_animal_score
    dr.loc[rowNum, 'Fluency Food Score'] = fluency_food_score

    # Write the results to the result file
    dr.to_excel('C:/Users/chanh/Downloads/aPD_cognition_result.xlsx', index=False)
