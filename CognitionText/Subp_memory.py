# SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr>
# SPDX-License-Identifier: GPL-3.0-or-later

import re

def Subp_memory(memory_text):

    # Find and extract patient score, normal score, and reading
    memory_patient_text = memory_text.split("시각")[0].strip()
    memory_normal_text = memory_text.split("시각")[1].split("교육")[0].strip()
    memory_reading_text = memory_text.split("교육")[1].split("MQ")[0].strip()
    memory_MQ = memory_text.split("MQ")[1].strip()

    [trial_scores, ka_delayed_recall, ka_delayed_recogn, kc_drawing, kc_immediate_recall, kc_delayed_recall] = Subp_memory_patient(memory_patient_text)
    [mq_score] = Subp_memory_MQ(memory_MQ)

    return [trial_scores, ka_delayed_recall, ka_delayed_recogn, kc_drawing, kc_immediate_recall, kc_delayed_recall, mq_score]

def Subp_memory_patient(memory_patient_text):

    # Extract patient's memory trials
    trial_pattern = r"K-A 시행(\d+):\s*(\d+)"
    trial_matches = re.findall(trial_pattern, memory_patient_text)
    trial_scores = [int(m[1]) for m in trial_matches]

    # Print patient's memory trials
    # for i, score in enumerate(trial_scores):
    #     print(f"K-A 시행 {i+1}: {score}")

    # Split patient's memory text into trial and rest
    split_index = memory_patient_text.find("K-A 지연회상:")
    memory_patient_trial = memory_patient_text[:split_index].strip()
    memory_patient_rest = memory_patient_text[split_index:].strip()

    # Extract delayed recall and delayed recognition
    ka_delayed_recall_match = re.search(r"지연회상[:\s]*(\d+(?:\.\d+)?)\s*K-A", memory_patient_rest)
    ka_delayed_recall = float(ka_delayed_recall_match.group(1)) if ka_delayed_recall_match else None
    ka_delayed_recogn_match = re.search(r"지연재인[:\s]*(\d+(?:\.\d+)?)\s*", memory_patient_rest)
    ka_delayed_recogn = float(ka_delayed_recogn_match.group(1)) if ka_delayed_recogn_match else None

    # Print delayed recall and delayed recognition
    # print(f"K-A 지연회상: {ka_delayed_recall}")
    # print(f"K-A 지연재인: {ka_delayed_recogn}")

    # Extract other memory scores
    kc_drawing_match = re.search(r"그리기[:\s]*(\d+(?:\.\d+)?)\s*K-C", memory_patient_rest)
    kc_drawing = float(kc_drawing_match.group(1)) if kc_drawing_match else None
    kc_immediate_recall_match = re.search(r"즉시회상[:\s]*(\d+(?:\.\d+)?)\s*K-C", memory_patient_rest)
    kc_immediate_recall = float(kc_immediate_recall_match.group(1)) if kc_immediate_recall_match else None
    kc_delayed_recall_match = re.search(r"지연회상[:\s]*(\d+(?:\.\d+)?)\s*", memory_patient_rest)
    kc_delayed_recall = float(kc_delayed_recall_match.group(1)) if kc_delayed_recall_match else None

    # Print other memory scores
    # print(f"K-C 그리기: {kc_drawing}")
    # print(f"K-C 즉시회상: {kc_immediate_recall}")
    # print(f"K-C 지연회상: {kc_delayed_recall}")

    return [trial_scores, ka_delayed_recall, ka_delayed_recogn, kc_drawing, kc_immediate_recall, kc_delayed_recall]

def Subp_memory_MQ(memory_MQ):

    # Extract memory MQ
    mq_pattern = r"score[:\s]*(\d+)\s*점"
    mq_match = re.search(mq_pattern, memory_MQ)
    mq_score = int(mq_match.group(1)) if mq_match else None

    # Print memory MQ
    # print(f"MQ score: {mq_score}", "점")

    return [mq_score]