## 미국 주 지도 데이터
## 11-1. 미국 주별 강력 범죄율 단계 구분도 만들기
## 패키지 준비하기
install.packages("ggiraphExtra")
library(ggiraphExtra)

## 미국 주별 범죄 데이터 준비하기
str(USArrests)

head(USArrests)

library(tibble)

# 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = "state")
crime

# 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state <- tolower(crime$state)
crime

str(crime)


## 미국 주 지도 데이터 준비하기
library(ggplot2)
states_map <- map_data("state")
str(states_map)


## 단계 구분도 만들기
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map)     # 지도 데이터


## 인터랙티브 단계 구분도 만들기
ggChoropleth(data = crime,
             aes(fill = Murder,
                 map_id = state),
             map = states_map,
             interactive = T)      # 인터랙티브



## 11-2. 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기
## 대한민국 시도별 인구 단계 구분도 만들기
## 패키지 준비하기
install.packages("string")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)


## 대한민국 시도별 인구 데이터 준비하기
str(changeCode(korpop1))


library(dplyr)
korpop1 <- rename(korpop1,
                  
                  fpop = 외국인_계_명)

str(changeCode(korpop1))


## 단계 구분도 만들기
library(ggiraphExtra)
ggChoropleth(data = korpop1,       # 지도에 표현할 데이터  
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도데이터
             interactive = T )     # 인터랙티브




## 대한민국 시도별 결핵 환자 수 단계 구분도 만들기
str(changeCode(tbc))

library(ggiraphExtra)
ggChoropleth(data = tbc,           # 지도에 표현할 데이터  
             aes(fill = NewPts,    # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도데이터
             interactive = T )     # 인터랙티브


library(foreign)
library(dplyr)
library(ggplot2)

# 복사본 만들기
korpop11 <- changeCode(korpop1)
korpop11

str(korpop11)
summary(korpop11)

tbc2 <- changeCode(tbc)
tbc2
str(tbc2)
###############################################################################
# 부산지역에서 년도와 결핵환자수의 관계
# 부산에 몇년도에 결핵환자수가 많았는가

# 1. 변수 검토하기
class(korpop11$name)
table(korpop11$name)

class(tbc2$name)
table(tbc2$name)


class(tbc2$year)
table(tbc2$year)

class(tbc2$NewPts)
table(tbc2$NewPts)

# 2. 전처리
# 이상치 확인
table(korpop11$name)
table(tbc2$name)

qplot(korpop11$name)

summary(tbc2$NewPts)
tbc2$NewPts = as.numeric(tbc2$NewPts)
str(tbc2$NewPts)
table(tbc2$NewPts)
summary(tbc2$NewPts)

# 결측치 확인
table(is.na(tbc2$NewPts))

# 이상치 결측 처리(0 또는 9999는 NA처리)
tbc2$NewPts <- ifelse(tbc2$NewPts %in% c(0,99999),NA,tbc2$NewPts)
table(is.na(tbc2$NewPts))




# 년도와  부산의 결핵환자수의 관계 분석하기
# 1. 년도에 따른 결핵환자수 평균표 만들기
year_pts<- tbc2 %>% 
  filter(!is.na(name) & name == "부산광역시") %>% 
  group_by(year) %>% 
  summarise(mean_NewPts = mean(NewPts))
year_pts



# 2. 그래프 만들기
library(ggplot2)
ggplot(data = year_pts, aes(x =year, y =mean_NewPts)) + geom_col()


#############################################################################
# 지역별 외국인 수 관계
# 1. 변수 검토하기
class(korpop11$name)
table(korpop11$name)

class(korpop11$fpop)
table(korpop11$fpop)
korpop11$fpop = as.numeric(korpop11$fpop)

# 지역과 외국인 수 관계 비교하기
# 1. 지역에 따른 외국인 수 평균표 만들기
name_fpop<- korpop11 %>% 
  filter(!is.na(name)) %>% 
  group_by(name) %>% 
  summarise(mean_fpop = mean(fpop))
name_fpop

# 2. 그래프 만들기
library(ggplot2)
ggplot(data = name_fpop, aes(x =name, y =mean_fpop)) + geom_col()

library(ggiraphExtra)
library(ggiraphExtra)
ggChoropleth(data = name_fpop,       # 지도에 표현할 데이터  
             aes(fill = mean_fpop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도데이터
             interactive = T )     # 인터랙티브
#############################################################################
# 지역에 따른 아파트 수 분석하기
str(korpop11)
summary(korpop11)

class(korpop11$name)
table(korpop11$name)

class(korpop11$name)
table(korpop11$name)


korpop1 <- rename(korpop1,
                  ap = 아파트_호)

korpop11 <- changeCode(korpop1)
str(korpop11)

korpop11$ap = as.numeric(korpop11$ap)



# 1. 지역에 따른 아파트 수 평균표 만들기
name_ap<- korpop11 %>% 
  filter(!is.na(name)) %>% 
  group_by(name) %>% 
  summarise(mean_ap = mean(ap))
name_ap



ggChoropleth(data = name_ap,       # 지도에 표현할 데이터  
             aes(fill = mean_ap,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도데이터
             interactive = T )     # 인터랙티브









#############################################################################
# 지역에 따른 남 여 비율 분석
str(korpop11)
class(korpop11$name)
table(korpop11$name)

class(korpop11$fpop)
table(korpop11$fpop)

korpop1 <- rename(korpop1,
                  female = 여자_명)

korpop11 <- changeCode(korpop1)
str(korpop11)

korpop11$pop = as.numeric(korpop11$pop)
korpop11$female = as.numeric(korpop11$female)
str(korpop11)
summarise()

str(korpop11$female)
name_female = korpop11 %>% 
  filter(!is.na(name)) %>% 
  group_by(name) %>% 
  summarise(pct_f = round(female/pop*100,1)) %>% 
  mutate(pct_m = 100 - pct_f)
name_female

ggplot(data = name_female, aes(x =name, y =pct_f)) + geom_col() +
  ylim(0,100)
################################################################################
## 2015년 부산의 인구의 결핵환자 수의 비율
str(korpop11)
str(tbc2)
str(tbc2$name)
str(tbc2$year)
str(tbc2$NewPts)
table(tbc2$year)

# 부산의 환자수
year_pts<- tbc2 %>% 
  filter(!is.na(name) & name == "부산광역시" &  year == "2015") %>% 
  group_by(year) %>% 
  summarise(mean_NewPts = mean(NewPts)) %>% 
  mutate(name = "부산광역시")
year_pts

# 부산의 총 인구
busan<- korpop11 %>% 
  filter(!is.na(name) & name == "부산광역시") %>% 
  group_by(name) %>% 
  summarise(busan_total = sum(pop))
busan

busan_2015 <- left_join(year_pts, busan, by = "name")
busan_2015
str(busan_2015)

# 2015년 부산의 인구의 결핵환자 수의 비율

busan_2015 %>% 
mutate(per =  mean_NewPts / busan_total *100)
