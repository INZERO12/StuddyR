# 5. 데이터 분석 기초
# 05-1. 데이터 파악하기
# 데이터 확인 및 컨트롤하기
# 1. 데이터 확인
# head(): 데이터의 첫번째 행부터 출력(default 6개 데이터 조회)
# tail(): 데이터의 마지막 행부터 출력(default 6개 데이터 조회)
# View(): 뷰어 창에서 데이터 출력(R-Studio 새로운 tab에서 오픈됨)
# dim(): 데이터의 차원 출력
# str(): 데이터의 속성(type)을 출력
# summary(): 데이터의 요약(기초)통계를 출력

# 데이터확인하기 -> 데이터 준비
getwd()
exam <- read.csv("./Data/csv_exam.csv")
exam


head(exam,10)                      # 앞에서 10개 출력

tail(exam,10)                      # 뒤에서 10개 출력

View(exam)                         # 뷰어 창에서 확인하기

dim(exam)                          # 행과 열 확인하기

str(exam)                          # 데이터 타입 및 속성 확인하기

summary(exam)                      # 데이터의 요약(기초) 통계 확인하기



# mpag 데이터 확인하기 -> 자동차 연비 데이터(내장데이터
# ggplot2의 mpg 데이터를 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg)
mpg

# 데이터 앞부분 10개 조회
head(mpg,10)

# 데이터의 타입과 속성 조회
str(mpg)


# 2. 데이터 컨트롤
# 데이터 컨트롤에 사용되는 패키지 설치 및 로드하기
install.packages("dplyr")       # dplyr 설치
library(dplyr)                  # dplyr 로드

# 데이터 컨트롤을 위한 데이터 준비하기 -> 데이터 프레임 만들기
df_raw <- data.frame(var1=c(1,2,1),
                     var2=c(2,3,2))
df_raw

df_new<-df_raw  # 복사본생성
df_raw

df_new<-rename(df_new, v2=var2) # var2를 v2로 수정
df_new

# 데이터 프레임에 새로운변수(파생변수) 만들기
df <- data.frame(var1=c(4,3,8),
                 var2=c(2,6,1))
df

# 데이터프레임 만드는 방법 3가지
# 1. 직접 만들기
# 2. 파일 불러오기
# 3. 내장 데이터


df$var_sum <- df$var1 + df$var2     # var_sum 파생변수 생성
# df$var_sum <- 10                    # 값만 넣어주면, 모두 같은 값 들어감
df


df$var_mean <-(df$var1 + df$var2)/2 # var_mean 파생변수 생성
df

# 아직 실제로 올라간것은 아니다 -> 끄면 사라진다


##------------------------------------------------------------------------------
mpg
mpg$total <- (mpg$cty + mpg$hwy)/2  # 통합 연비 변수 생성
head(mpg)
mean(mpg$total)                     # 통합 연비 변수 평균

summary(mpg$total)                  # 요약 통계량 산출
hist(mpg$total)                     # 히스토그램 생성


# 조건문 사용하여 통합연비 합격 여부 조건 처리 -> test 변수 추가하기
# 20이상이면 pass, 아니면 fail
mpg$test <- ifelse(mpg$total >= 20, "pass","fail")
head(mpg,20)                        # 데이터 확인

# 통합 연비 빈도표 조회
# 각 데이터값 count
table(mpg$test)


# 통합 연비 빈도 막대 그래프로 표현하기
library(ggplot2)  # ggplot2 로드
qplot(mpg$test)   # 연비 합격 빈도 막대 그래프 생성


# 데이터 컨트롤 -> 중첩 조건문을 활용하여 통합연비 등급 변수 추가하기
# total을 기준으로 A,B,C 등급 부여(등급->범주)
mpg$grade <- ifelse(mpg$total >= 30, "A",ifelse(mpg$total >=20, "B", "C"))
head(mpg)
table(mpg$grade)  # 등급 빈도표 조회
qplot(mpg$grade)  # 등급 빈도 막대 그래프 그리기




##------------------------------------------------------------------------------
# ggplot2 패키지에는 미국 동북중부 437개 지역의 인구통계 정보를 담은 midwest라는 데이터가 포함(내장 데이터)되어 있다.
# 문제1. ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러와서 데이터의 특성을 파악하세요
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)

# 문제2. poptotal(전체인구)을 total로, popasian(아시아 인구)를 asian으로 변수명을 수정하세요.
midwest<-rename(midwest, total=poptotal)
midwest<-rename(midwest, asian=popasian)
head(midwest)
# 문제3. total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율' 파생변수를 만들고, 히스토그램을 만들어
# 도시들이 어떻게 분표하는지 살표호세요.
midwest$a<-midwest$asian/midwest$total*100
hist(midwest$a)
# 문제4. 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large",
# 그 외에는 "small"을 부여하는 파생변수를 만들어 보세요.
b = mean(midwest$a)
midwest$group <- ifelse(midwest$a >b, "large","small")

# 문제5. "large"와 "small"에 해당하는 지역이 얼마나 되는지, 빈도표와 빈도 막대그래프를 만들어 확인해 보세요.
qplot(midwest$group)
table(midwest$group)
