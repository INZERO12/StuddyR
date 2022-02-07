################################################################################
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


##------------------------------------------------------------------------------
# 데이터 전처리
# 함수명 : 기능
# filter() : 행 추출
# select() : 열(변수) 추출
# arrange() : 정렬
# mutate() :  변수 추가
# summarise() : 통계치 산출
# group_by() : 집단별로 나누기
# left_join() : 데이터 합치기(열)
# bind_row():데이터 합치기(행)



exam

# exam 에서 class가 1인 경우만 추출하여 출력
exam %>% filter(class ==1)  # %>% => '~ 중에서' 라는 의미
# 참고) [Ctrl+Shit+M]으로 %>% 기호 입력


# 1반이 아닌 경우
exam %>% filter(class!=1)



# 여러 조건을 충족하는 행 추출하기
# 1반이면서 수학 점수가 50점 이상인 경우 / 그리고 => &
exam %>% filter(class ==1 & math >= 50)

# 또는=>|
exam %>% filter(math >= 90 | english >= 60)


# 목록에 해당하는 행 추출하기
# 1, 3, 5반에 해당되면 추출
exam %>% filter(class ==1 | class ==3 | class ==5)

exam %>% filter(class %in% c(1,2,3))


# 추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1) # class가 1인 행 추출, class1에 할당
class2 <- exam %>% filter(class == 2) # class가 2인 행 추출, class2에 할당

mean(class1$math)                     # 1반 수학 점수 평균 구하기
mean(class2$math)                     # 2반 수학 점수 평균 구하기


# R에서 사용하는 기호
# - 논리연산자
# 논리 연산자 기준 -> 왼쪽
# - 산술연산자



# mpg 데이터를 이용해 분석 문제를 해결해 보세요
mpg

# Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다.
# displ(배기량)이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요
class1 <- mpg %>% filter(displ <= 4)
class2 <- mpg %>% filter(displ >= 5)
class2
mean(class1$hwy)
mean(class2$hwy)


#Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. "audi"와 "toyota"중 어느 
#manufacture(자동차제조회사)의 cty(도시연비)가 평균적으로 더 높은지 알아보세요
class3 <- mpg %>% filter(manufacturer == "audi")
class4 <- mpg %>% filter(manufacturer == "toyota")
mean(class3$cty)
mean(class4$cty)


# Q3. "chevrolet","ford","honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다.
# 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요

mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda"))
mean(mpg_new$hwy)




# 변수 추출하기
exam %>% select(math)   # math만 추출


# 여러 변수 추출하기
exam %>% select(math,science)

# 변수 제외하기 
exam %>% select(-math)  # math 제외
exam %>% select(-math, -english)  # math, english 제외


# dplyr 함수 조합하기
# class가 1인 행만 추출한 다음 english 
# 행 추출 : filter()
# 열(변수) 추출 : select()
exam %>% filter(class == 1) %>% select(english)

# 들여쓰기
exam %>%
  filter(class == 1) %>% 
  select(english)

# mpg 데이터를 이용해서 분석 문제를 해결해보세요
# Q1. mpg데이터는 11개 변수로 구성되어 있습니다. 이 중 일부만 추출해서 분석에 활용하려고 합니다
# mpg데이터에서 class(자동차종류), cty(도시연비)변수를 추출해 새로운 데이터를 만드세요. 새로 만든
# 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인

a <- mpg %>%  select(class,cty)
head(a)

# Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 앞에서 추출한 데이터를 이용해서
# class가 "suv"인 자동차와 "compact"인 자동차 중 어떤 자동차의 cty가 더 높은지 알아보세요
b <- a %>% filter(class == "suv")
c <- a %>% filter(class == "compact")
suv_mean <- mean(b$cty)
compact_mean<-mean(c$cty)

