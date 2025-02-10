import re

def Subp_frontallobe(frontallobe_text):

    # Find and extract patient score, normal score, and reading
    frontallobe_patient_text = frontallobe_text.split("(1)")[1].strip()
    frontallobe_normal_text = frontallobe_text.split("(1)")[2].strip()
    
    print("[전두엽성 기능] Stroop Test & Word Fluency Test")

    Subp_frontallobe_patient(frontallobe_patient_text)
    print("==============================")

    return None

def Subp_frontallobe_patient(frontallobe_patient_text):

    frontallobe_stroop_text, frontallobe_fluency_text = frontallobe_patient_text.split("(2)")
    
    # Extract patient's Stroop test score
    stroop_simple_text = frontallobe_stroop_text.split("중간")[0].strip()
    stroop_middle_text = frontallobe_stroop_text.split("중간")[1].split("간섭")[0].strip()
    stroop_interfere_text = frontallobe_stroop_text.split("간섭")[1].strip()

    stroop_simple_score_match = re.search(r"환산점수[:\s]*(\d+)\s*점\s*시행 시간[:\s]*(\d+)\s*초\s*오류수[:\s]*(\d+)\s*개", stroop_simple_text)
    if stroop_simple_score_match:
        stroop_simple_score = int(stroop_simple_score_match.group(1))
        stroop_simple_time = int(stroop_simple_score_match.group(2))
        stroop_simple_error = int(stroop_simple_score_match.group(3))
    stroop_middle_score_match = re.search(r"환산점수[:\s]*(\d+)\s*점\s*시행 시간[:\s]*(\d+)\s*초\s*오류수[:\s]*(\d+)\s*개", stroop_middle_text)
    if stroop_middle_score_match:
        stroop_middle_score = int(stroop_middle_score_match.group(1))
        stroop_middle_time = int(stroop_middle_score_match.group(2))
        stroop_middle_error = int(stroop_middle_score_match.group(3))
    stroop_interfere_score_match = re.search(r"환산점수[:\s]*(\d+)\s*점\s*시행 시간[:\s]*(\d+)\s*초\s*오류수[:\s]*(\d+)\s*개", stroop_interfere_text)
    if stroop_interfere_score_match:
        stroop_interfere_score = int(stroop_interfere_score_match.group(1))
        stroop_interfere_time = int(stroop_interfere_score_match.group(2))
        stroop_interfere_error = int(stroop_interfere_score_match.group(3))
    
    # Print patient's Stroop test score
    print("> Stroop 단순시행: 환산점수", stroop_simple_score, "점, 시간", stroop_simple_time, "초, 오류수", stroop_simple_error, "개")
    print("> Stroop 중간시행: 환산점수", stroop_middle_score, "점, 시간", stroop_middle_time, "초, 오류수", stroop_middle_error, "개")
    print("> Stroop 간섭시행: 환산점수", stroop_interfere_score, "점, 시간", stroop_interfere_time, "초, 오류수", stroop_interfere_error, "개")

    # Extract patient's Word Fluency test score
    fluency_total_text = frontallobe_fluency_text.split('ㅅ')[0].strip()
    fluency_total_score_match = re.search(r"score[:\s]*(\d+)\s*\(", fluency_total_text)
    if fluency_total_score_match:
        fluency_total_score = int(fluency_total_score_match.group(1))

    fluency_s_text = frontallobe_fluency_text.split('ㅅ')[1].split('ㄱ')[0].strip()
    fluency_s_score_match = re.search(r"단어\s*(\d+)\s*", fluency_s_text)
    fluency_s_score = int(fluency_s_score_match.group(1))
    fluency_g_text = frontallobe_fluency_text.split('ㄱ')[1].split('동물')[0].strip()
    fluency_g_score_match = re.search(r"단어\s*(\d+)\s*", fluency_g_text)
    fluency_g_score = int(fluency_g_score_match.group(1))
    fluency_animal_text = frontallobe_fluency_text.split('동물')[1].split('음식')[0].strip()
    fluency_animal_score_match = re.search(r"단어\s*(\d+)\s*", fluency_animal_text)
    fluency_animal_score = int(fluency_animal_score_match.group(1))
    fluency_food_text = frontallobe_fluency_text.split('음식')[1].strip()
    fluency_food_score_match = re.search(r"단어\s*(\d+)\s*", fluency_food_text)
    fluency_food_score = int(fluency_food_score_match.group(1))

    # Print patient's Word Fluency test score
    print("> Word Fluency 환산점수: ", fluency_total_score, "점")
    print("> Word Fluency 'ㅅ' 단어: ", fluency_s_score, "개")
    print("> Word Fluency 'ㄱ' 단어: ", fluency_g_score, "개")
    print("> Word Fluency 동물 분류: ", fluency_animal_score, "개")
    print("> Word Fluency 음식 분류: ", fluency_food_score, "개")

    return None