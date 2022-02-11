# 데이터 프레임
# 1. 데이터프레임 만들기
# 영어 점수 변수 생성
english <- c(90,80,60,70)
english



# 수학 점수 변수 생성
math <- c(50,60,100,20)
math

# english, math 데이터로 데이터 프레임을 생성해서 df_midterm에 할당(저장)
df_midterm <- data.frame(english,math)
df_midterm



# 시험 성적 데이터에 반(class) 변수 추가하기
class<- c(1,1,2,3)
class

df_midterm <- data.frame(english,math,class) 
# 클래스.클래스 안에 있는 함수(data란 클래스 안에 frame란 함수가 있다)
df_midterm
## english math class
## 1      90   50     1
## 2      80   60     1
## 3      60  100     2
## 4      70   20     3
## ㄴ 인덱스 번호
## 3행 4열 데이터프레임


# df_midterm의 english로 평균산출
mean(df_midterm$english)


# df_midterm의 math로 평균 산출
mean(df_midterm$math)

# readxl 패키지 설치
install.packages("readxl")
# readxl 패키지 로드
library(readxl)

# 엑셀 파일을 불러와서 df_exam 에 저장하기
setwd("C:/Recture/Busan_202202_R/1day/Data")
getwd()
df_exam <- read_excel("./excel_exam.xlsx")
df_exam                    # 출력 5열 20행의 데이터프레임


# 2. 외부 데이터를 이용하여 데이터 프레임 만들기
# 데이터 활용하기 -> mean( )
mean(df_exam$english)
mean(df_exam$science)


# 상대경로 : 현재 프로그래밍 파일의 위치를 기준으로 함
# df_exam <- read_excel("./excel_exam.xlsx")

# 절대경로 : 드라이브 최상위 위치를 기준으로 함
# df_exam <- read_excel("C:/Recture/Busan_202202_R/1day/Data/excel_exam.xlsx")
# [주의] 절대경로 표현 시에는 Working directory에 불러올 파일이 있어야 함

# 엑셀 데이터의 첫 번째 행에 변수명이 없는 경우 -> col_names =F
df_exam_novar = read_excel('./excel_exam_novar.xlsx', col_names=F)
df_exam_novar

# 엑셀 파일 내에 시트가 여러개 있는 경우 읽어 들일 시트 지정하기 -> sheet = 1
df_exam_sheet <- read_excel('./excel_exam_sheet.xlsx', sheet = 3)
df_exam_sheet

# csv파일 읽어 들이기
# csv 데이터는 값과 값 사이가 콤파(,)로 구분되어 있음
# 범용 데이터 형식(text형식)으로 용량이 작고, 다양한 소프트웨어에서 open됨
df_csv_exam <- read.csv("./csv_exam.csv")
df_csv_exam




# 데이터 프레임을 csv파일로 저장
df_midterm <- data.frame(english = c(90,80,60,70),
                         math = c(50,60,100,20),
                         class = c(1,1,2,2))
df_midterm

# 데이터 프레임 csv파일로 저장하기
write.csv(df_midterm, file = "./df_midterm.csv")














