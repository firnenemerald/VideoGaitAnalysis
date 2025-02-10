import re
import pandas as pd

def Subp_attention(attention_text):

    # Find and extract patient score, normal score, and reading
    attention_patient_text = attention_text.split('세')[0]
    attention_normal_text = attention_text.split('세')[1].split('1.')[0]

    print("[주의력] Trail Making Test (TMT)")

    Subp_attention_patient(attention_patient_text)
    # Subp_attention_normal(attention_normal_text)

    # Print reading
    # print("(판독)", attention_reading_text)
    print("==============================")

    return None

def Subp_attention_patient(attention_patient_text):
    # Find and extract patient's attention score A, B, C
    attention_A = ''
    attention_B = ''
    attention_C = ''
    part_a_index = attention_patient_text.find('Part A')
    part_b_index = attention_patient_text.find('Part B')
    part_c_index = attention_patient_text.find('Part C')
    if part_a_index != -1 and part_b_index != -1:
        attention_A = attention_patient_text[part_a_index + len('Part A'):part_b_index].strip()
    if part_b_index != -1 and part_c_index != -1:
        attention_B = attention_patient_text[part_b_index + len('Part B'):part_c_index].strip()
    if part_c_index != -1:
        attention_C = attention_patient_text[part_c_index + len('Part C'):].strip()

    # Get patient part A, B, C time and error
    tmt_pattern = r"시행\s*시간:\s*(\d+)\s*초\s+오류수:\s*(\d+)\s*개"
    part_a_match = re.search(tmt_pattern, attention_A)
    if part_a_match:
        part_a_time = int(part_a_match.group(1))
        part_a_error = int(part_a_match.group(2))
    part_b_match = re.search(tmt_pattern, attention_B)
    if part_b_match:
        part_b_time = int(part_b_match.group(1))
        part_b_error = int(part_b_match.group(2))
    part_c_match = re.search(tmt_pattern, attention_C)
    if part_c_match:
        part_c_time = int(part_c_match.group(1))
        part_c_error = int(part_c_match.group(2))
    
    # Print patient's attention score
    print("> Part A: 시간", part_a_time, "초, 오류수", part_a_error, "개")
    print("> Part B: 시간", part_b_time, "초, 오류수", part_b_error, "개")
    print("> Part C: 시간", part_c_time, "초, 오류수", part_c_error, "개")

    return None

def Subp_attention_normal(attention_normal_text):
    # Find and extract normal score
    attention_normal_group, attention_normal_abc = attention_normal_text.split('A:')
    attention_normal_a, attention_normal_bc = attention_normal_abc.split('B:')
    attention_normal_b, attention_normal_c = attention_normal_bc.split('C:')

    # Strip normal group text
    attention_normal_group = attention_normal_group.strip()

    # Get normal part A, B, C time and error
    tmtn_pattern = r"(\d+(?:\.\d+)?)초\(오류수:(\d+(?:\.\d+)?)\)"
    partn_a_match = re.search(tmtn_pattern, attention_normal_a)
    if partn_a_match:
        partn_a_time = float(partn_a_match.group(1))
        partn_a_error = float(partn_a_match.group(2))
    partn_b_match = re.search(tmtn_pattern, attention_normal_b)
    if partn_b_match:
        partn_b_time = float(partn_b_match.group(1))
        partn_b_error = float(partn_b_match.group(2))
    partn_c_match = re.search(tmtn_pattern, attention_normal_c)
    if partn_c_match:
        partn_c_time = float(partn_c_match.group(1))
        partn_c_error = float(partn_c_match.group(2))

    # Print normal attention score
    print("(참고)", attention_normal_group, ":")
    print("> Part A: 시간", partn_a_time, "초, 오류수:", partn_a_error, "개")
    print("> Part B: 시간", partn_b_time, "초, 오류수:", partn_b_error, "개")
    print("> Part C: 시간", partn_c_time, "초, 오류수:", partn_c_error, "개")

    return None