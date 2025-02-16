# SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr>
# SPDX-License-Identifier: GPL-3.0-or-later

import re

def Subp_language(language_text):

    # Find and extract patient score, normal score, and reading
    language_patient_text = language_text.split('세')[0]
    language_normal_text = language_text.split('세')[1]

    [language_score] = Subp_language_patient(language_patient_text)
    # Subp_language_normal(language_normal_text)

    return [language_score]

def Subp_language_patient(language_patient_text):
    # Extract patient's language score
    language_pattern_match= re.search(r":\s*(\d+)\s*/", language_patient_text)
    language_score = int(language_pattern_match.group(1)) if language_pattern_match else None

    # Print patient's language score
    # print("> 점수:", language_score)

    return [language_score]

def Subp_language_normal(language_normal_text):
    # Find and extract normal language group and score
    language_normal_group, language_normal_score_text = language_normal_text.split('세')

    # Strip normal language score group
    language_normal_group = language_normal_group.strip()
    
    # Extract normal language score
    language_normal_score_match = re.search(r"\s*(\d+(?:\.\d+)?)\s*\/", language_normal_score_text)
    language_normal_score = float(language_normal_score_match.group(1)) if language_normal_score_match else None

    # Print normal language score
    print("(참고)", language_normal_group, "세 :")
    print("> 점수:", language_normal_score)

    return None