# SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr>
# SPDX-License-Identifier: GPL-3.0-or-later

import re

def Subp_sensorimotor(sensorimotor_text):

    print("[감각-운동 조정] Grooved Pegboard Test")

    sensorimotor_name, sensorimotor_LR_text = sensorimotor_text.split("왼손")
    sensorimotor_L_text, sensorimotor_R_text = sensorimotor_LR_text.split("오른손")

    sm_pattern = r"시행\s*시간:\s*(\d+)\s*초\s+오류수:\s*(\d+)\s*개"
    sensorimotor_L_match = re.search(sm_pattern, sensorimotor_L_text)
    sensorimotor_R_match = re.search(sm_pattern, sensorimotor_R_text)
    if sensorimotor_L_match:
        sensorimotor_L_time = int(sensorimotor_L_match.group(1))
        sensorimotor_L_error = int(sensorimotor_L_match.group(2))
    if sensorimotor_R_match:
        sensorimotor_R_time = int(sensorimotor_R_match.group(1))
        sensorimotor_R_error = int(sensorimotor_R_match.group(2))
    
    print("> 왼손: 시간", sensorimotor_L_time, "초, 오류수", sensorimotor_L_error, "개")
    print("> 오른손: 시간", sensorimotor_R_time, "초, 오류수", sensorimotor_R_error, "개")
    print("==============================")

    return None