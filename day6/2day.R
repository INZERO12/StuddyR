library(dplyr)
exam <- read.csv("./Data/csv_exam.csv")
exam

# 오름차순으로 정렬하기
exam %>% arrange(math)  # math 오름차순 정렬

# 내림차순으로 정렬하기
exam %>% arrange(desc(math))  # math 내림차순 정렬

# 정렬 기준 변수 여러개 지정
exam %>% arrange(class,math)  # class 오름차순 정렬 후, math 오름차순 정렬

# mpg 데이터를 이용해서 분석 문제 해결
# "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 한다.
mpg <- as.data.frame(ggplot2::mpg)
mpg
audi <- mpg %>% filter(manufacturer == "audi")
f_audi<-audi %>% arrange(desc(hwy))

# "audi"에서 생산한 자동차 중 hwy가 1~~5위에 해당하는 자동차의 데이터를 출력하세요
head(f_audi,5)
# mpg %>% filter(manufacturer == "audi") %>% arrange(desc(hwy)) %>% head(5)



## 파생변수 추가하기
exam %>% 
  mutate(total = math + english +science) %>% # 총합 변수 추가
  head


## 여러 파생변수 한 번에 추가하기
exam %>% 
  mutate(total = math + english +science,          # 총합 변수 추가
         mean = (math + english + science)/3) %>%  # 총평균 변수 추가
  head()
  
  
## mutate()에 ifelse() 적용하기
exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head()


exam


## Q1. mpg데이터 복사본을 만들고, cty 와 hwy를 더한 '합산 연비 변수'를 추가하세요.
new <- mpg
new
a <- new %>% 
  mutate(total = cty + hwy)
head(a)

## Q2. 앞에서 만든 '합산 연비 변수'를 2로 나누 '평균연비변수'를 추가하세요
b<- new %>% 
  mutate(total_mean =a$total/2 )
head(b)

## Q3. '평균연비변수'가 가장높은 자동차 3종의 데이터를 출력하세요
b %>% arrange(desc(total_mean)) %>% 
  head(3)
##Q4. 1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 데이터는 복사본 대신 mpg 원본을 이용하세요
mpg %>% mutate(total = cty + hwy) %>% mutate(total_mean =(cty+hwy)/2 )  %>% arrange(desc(total_mean)) %>% head(3)




# 집단별로 요약하기
exam %>%  summarise(mean_math = mean(math)) # math평균산출


exam %>% 
  group_by(class) %>%   # class별로 분리
  summarise(mean_math = mean(math)) # math평균산출






exam %>% 
  group_by(class) %>% # class 별로 분리
  summarise(maen_math = mean(math),   # math 평균
            sum_math = sum(math),     # math 합계
            median_meth = median(math), # math 중앙값
            n=n()) # 학생수

# 각 집단별로 다시 집단 나누기
mpg
mpg %>% 
  group_by(manufacturer, drv) %>%  # 회사별, 구간방식별 분리
  summarise(mean_cty = mean(cty)) %>%  # cty 평균 산출
  head(10)



# 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순 정렬
# 1~5위까지 출력
library(dplyr)
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=="suv") %>% 
  mutate(tot =(hwy+cty)/2) %>% 
  summarise(mean3=mean(tot)) %>% 
  arrange(desc(mean3))%>% 
  head(5)


# Q1. mpg데이터의 class눈 "suv","compact"등 자동차를 특징에 따라 일곱 종류로 분류한 변수
# 어떤 차종의 연비가 높은지 비교. class 별  cty 평균 구하여라
mpg
mpg %>% 
  group_by(class) %>% 
  summarise(mean(yy))


# Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다.
# 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력
mpg %>% 
  group_by(class) %>% 
  summarise(yy = mean(cty)) %>% 
  arrange(desc(yy))

# Q3. 어떤 회사의 자동차의 hwy가 가장 높은지 알아보려 한다.
  # hwy평균이 가장 높은 회사 세곳 출력
mpg %>% 
  group_by(class) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

# Q4. 어떤 회사에서 "compact"차종을 가장 많이 생상하는지 알아보려 한다.
  # 각 회사별 "compact"차종 수를 내림차순으로 정렬
mpg
mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% # 빈도 구하기
  arrange(desc(count))





# 06-7. 데이터 합치기
# 가로로 합치기
# 데이터 생성
# 중간고사 데이터 생성
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))

# 기말고사 데이터 생성
test2 <- data.frame(id = c(1,2,3,4,5),
                     final = c(70,83,65,95,80))


test1
test2

###### 옆으로 합치기
# id기준으로 합치기
total <- left_join(test1, test2, by = "id")  # id 기준으로 합쳐 total에 할당
total
# by에 변수명을 지정할때 변수명 앞 뒤에 곂따음표 입력



# 다른 데이터 활용해 변수 추가하기
# 반별 담임교사 명단 생성
name <- data.frame(class =c(1,2,3,4,5),
                   teacher =c("kim","lee","park","choi","jung"))
name


# class 기준 합치기
exam_new <- left_join(exam, name, by = "class")
exam_new

##### 밑으로 합치기
# 세로로 합치기
# 데이터 생성
# 학생 1~5번 시험 데이터 생성
group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60,80,70,90,85))

# 학생 6~10전 시험 데이터 생성
group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70,83,65,95,80))


group_all <- bind_rows(group_a,group_b)  # 데이터 합쳐서 group_all에 할당
group_all                                # group_all 출력



# mpg 데이터의 f1변수는 자동차에 사용하는 연료
# 연료와 가격으로 구성된 데이터 프레임 생성
furl <- data.frame(fl = c("c","d","e","p","r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)      # factor 자동변경 방지
furl


# Q1. mpg데이터에는 연료 종류를 나타낸 fl변수는 있지만 연료 가격을 나타낸 변수는 없다.
# 위에서 만든 furl 데이터를 이용해서 mpg 데이터에 price_fl(연료가격)변수 추가

total <- left_join(mpg,furl, by ="fl")
head(total)

# Q2. 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 model,fl, price_fl 변수를 추출해 앞부분 5행을 출력
a<-total %>% select(model,fl,price_fl)
head(a,5)




### 정리하기
# 1. 조건에 맞는 데이터만 추출하기
# 2. 필요한 변수만 추출하기
# 3. 함수 조합하기, 일부만 출력하기
# 4. 순서대로 정렬하기
# 5. 파생변수 추가하기
## mutate()에 ifelse() 적용하기
## 추가한 변수를 dplyr패키지에 활용
# 6. 집단별로 요약하기
# 7. 데이터 합치기
## 가로로합치기 / 세로로 합치기




################################################################################
## 7. 데이터 정제
## 빠진 데이터, 이상한 데이터 제거하기
##
## 07-1. 결측치 정제하기
## 결측치
## - 누락된 값, 비어있는 값
## - 함수 적용 불가, 분석 결과 왜곡
## - 제거 후 분석 실시
################################################################################

# 결측치 만들기
# 결측치 표기 - 대문자 NA
# NA 앞 뒤에 곂따음표 없음
df <- data.frame(sex = c("M","F",NA,"M","F"),
                 score = c(5,4,3,4,NA))
df



# 결측치 확인하기
is.na(df) # 결측치 확인 TRUE or FALSE

table(is.na(df))   # 결측치 빈도 출력



# 변수별로 결측치 확인하기
table(is.na(df$sex))
table(is.na(df$score))

# 결측치 포함된 상태로 분석
mean(df$score)
sum(df$score)
# 중간에 결측치 있으면 사칙연산 안됨


# 결측치 제거하기
# 결측치 있는 행 제거하기
library(dplyr)
df %>% filter(is.na(score)) # score가 NA인 데이터만 출력

df %>%  filter(!is.na(score)) # score 결측치 제거

# 결측치 제외한 데이터로 분석하기
df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

df_nasex <- df %>% filter(!is.na(sex))
df_nasex

# 여러 변수 동시에 결측치 없는 데이터 추출하기
# score, sex 결측치 제거
df_nomiss <- df %>%  filter(!is.na(score) & !is.na(sex))
df_nomiss

# 결측치가 하나라도 있으면 제거하기
# 분석에 필요한 데이터까지 손실 될 가능성 유의
# ex) 성별 소득 관계 분석하는데 지역 결측치까지 제거
df_nomiss2 <- na.omit(df)  # 모든 변수에 결측치 없는 데이터 추출
df_nomiss2


# 함수의 결측치 제외 기능 이용하기 => na.rm = T
mean(df$score, na.rm = T) # 결측치 제외하고 평균 산출
sum(df$score,na.rm = T)   # 결측치 제외하고 합계 산출




# summarise()에서 na.rm = T 사용하기
# 결측치 생성
exam
exam[c(3,8,15), "math"] <- NA # 3, 8, 15 행의 math에 NA 할당

# 평균 구하기
exam %>% summarise(mean_math = mean(math)) # 데이터에 NA있어서 결과 NA나옴

exam %>%  summarise(mean_math =mean(math, na.rm = T)) # 결측치 제외하고 평균 산출





# 결측치 대체하기
# - 결측치 많을 경우 모두 제외하면 데이터 손실 큼
# - 대안 : 다른 값 채워 넣기
#
# 결측치 대체법(Imputation)
# - 대표값(평균,최빈값 등)으로 일괄 대체
# - 통계분석 기법 적용, 예측값 추정해서 대체





# 평균으로 결측치 대체하기
exam$math <- ifelse(is.na(exam$math),55,exam$math)   # math가 NA면 55로 대체
table(is.na(exam$math))                              # 결측치 빈도표 -> 모두 FALSE=>결측치 대체 성공



# mpg 데이터에 결측치 할당
mpg
mpg[c(65,124,131,153,212),"hwy"] <- NA  # NA 할당하기
table(is.na(mpg))


# Q1. drv(구동방식)별로 hwy평균이 어떻게 다른지 알아보려 한다.
# 분석을 하기전에 우선 두 변수에 결측치가 있는지 확인
# drv변수와 hwy변수에 결측치가 몇개 있는가
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# Q2. filter()를 이용해 hwy변수의 결측치를 제외하고, 어떤 구동방식의 
# hwy 평균이 높은지 알아보세요. 하나의 dplyr구문으로 만들어야 합니다.

mpg %>%  
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))


# 07-2. 이상치 정제하기
# 이상치(Outier) - 정상범주에서 크게 벗어난 값
# - 이상치 포함시 분석 결과 왜곡
# - 결측 처리 후 제외하고 분석

# 이상치 제거하기 - 1. 존재할 수 없는 값
# 논리적으로 존재할 수 없으므로 바로 결측 처리 후 분석시 제외
# 이상치 포함된 데이터 생성 - sex3, score 6
outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outlier


# 이상치 확인하기
table(outlier$sex)
table(outlier$score)


# 결측 처리하기 - sex
# sex가 3이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier



# 결측 처리하기 - score
# score가 1~5아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier




# 결측치 제외하고 분석
outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))




# 이상치 제거하기 - 2. 극단적인 값
# - 정상범위 기준 정해서 벗어나면 결측 처리
# 판단기준    예
# 논리적판단  성인몸무게 40kg~150kg 벗어나면 극단치
# 통계적판단  상하위 0.3% 극단치 또는 상자그림 1.5 IQR 벗어나면 극단치



# 상자그림으로 극단치 기준 정해서 제거하기
# 상자그림 생성
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

# 상자그림 통계치 출력
boxplot(mpg$hwy)$stats
#       [,1]
# [1,]   12 # 최하위 극단치값
# [2,]   18
# [3,]   24
# [4,]   27
# [5,]   37 # 최상위 극단치 값




# 결측 처리하기
# 12~ 37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy >37, NA, mpg$hwy)
table(is.na(mpg$hwy))




# 결측치 제외하고 분석하기
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))



# drv(구동방식) 변수의 값은 4,f,r
# cty(도시연비)에는 극단적으로 크거나 작은 값 할당
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93),"drv"]<-"k"              # drv 이상치 할당
mpg[c(29,43,129,203),"cty"] <- c(3,4,39,42) # cty 이상치 할당
mpg


# Q1. drv에 이상치가 있는지 확인. 이상치를 결측 처리한 다음 이상치가 사라졌는지 확인.
# 결측치를 처리 할때는 %in% 기호를 활용
table(mpg$drv)
mpg$drv <- ifelse( mpg$drv %in% c("4","f","r"),mpg$drv,NA)
table(is.na(mpg$drv))

# Q2. 상자 그림을 이용해 cty에 이상치가 있는지 확인
# 상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후 다시 상자 그림을 만들어 이상치가 사라졌는지 확인
boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty >26, NA, mpg$cty)
boxplot(mpg$cty)

# Q3. 두 변수의 이상치를 결측처리 했으니 이제 분석할 차례입니다. 결측치를 제외한 다음 drv 별로
# cty 평균이 어떻게 다른지 알아보세요. 하나의 dplyr구문으로 만들어야 합니다
mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))
  



################################################################################
##08. 그래프 만들기
# 08-1.R로 만들 수 있는 그래프 살펴보기
# 08-2. 산점도 - 변수 간 관계 표현하기
# ggplot2 레이어 구조 이해하기
# 1단계 : 배경설정(축)
# 2단계 : 그래프 추가(점,막대,선)
# 3단계 : 설정 추가(축 범위, 색, 표식)


# 산점도 만들기
# - 산점도(Scatter Plot) : 데이터를 x축과 y축에 점으로 표현한 그래프
# - 나이와 소득처럼, 연속 값으로 된 두 변수의 관계를 표현할 때 사용
library(ggplot2)


# 1. 배경 설정하기
# x축 displ y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x=displ, y = hwy))

# 2. 그래프추가하기
# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()



# 3. 축 범위를 조정하는 설정 추가하기
# x축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3,6)

# x축 범위 3~6, y축 범위 10~30으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3,6) +
  ylim(10,30)


# ggplot 함수 구조
# ggplot2 코드 가독성 높이기
# 한줄로 작성
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3,6) +ylim(10,30)

# + 뒤에서 줄 바꾸기
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3,6) +
  ylim(10,30)


# ggplot() vs qplot()
# qplot() : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
# ggplot() : 최종 보고서용. 색, 크기, 폰트 등 세부 조작 가능



# Q1. mpg데이터의 cty와 hwy간에 어떤 관계가 있는지 알아보려 한다.
# x축은 cty, y축은 hwy로 된 산점도를 만들어라
mpg <- as.data.frame(ggplot2::mpg)
ggplot(data = mpg, aes(x=cty, y = hwy))+ geom_point()

# Q2. midwest 패키지이용
#x축은 poptotal, y축은 popasian으로 산점도 만들기
# 전체인구는 50만명이하, 아시아인 인구는 1만명이하인 지역만 산점도에 표시
midwest=as.data.frame(ggplot2::midwest)
options(scipen = 99)
ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() +
  xlim(0,500000) +
  ylim(0,10000)

# 정수로 표현 : options(scipen = 99) 실행 후 그래프 생성
# 지수로 표현 : options(scipen = 0) 실행 후 그래프 생성


# 08.3 막대 그래프 - 집단 간 차이 표현하기
# 막대 그래프 : 데이터의 크기를 막대의 길이로 표현한 그래프
# 성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용


# 막대 그래프 1 - 평균 막대 그래프 만들기
# 각 집단의 평균값을 막대 길이로 표현한 그래프
# 1. 집단별 평균표 만들기
library(dplyr)
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg



# 2. 그래프 생성하기
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()


# 3. 크기 순으로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv,-mean_hwy), y = mean_hwy)) + geom_col()



# 막대 그래프2 - 빈도 막대 그래프
# 값의 개수(빈도)로 막대의 길이를 표현한 그래프
# x축 변수, y축 빈도
ggplot(data = mpg, aes(x = drv)) + geom_bar()
# geom_bar() : 카운트의 범주
table(mpg$drv) # 확인


# x축 연속 변수, y축 빈도
ggplot(data = mpg, aes(x = hwy)) + geom_bar()


# Q1 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다.
# "suv"차종을 대상으로 평균 cty가 가장 높은 회사 다섯 곳을 막대 그래프로 표현
# 막대는 연비가 높은순 정렬
df <- mpg %>% 
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)


ggplot(data = df, aes(x = reorder(manufacturer,-mean_cty), y = mean_cty)) + geom_col()

# Q2. 자동차 중에서 어떤 class가 가장 많은지 알아보려 한다.
# 자동차 종류별 빈도 표현 막대그래프
ggplot(data=mpg, aes(x=class)) + geom_bar()
