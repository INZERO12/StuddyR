################################################################################
## 2. 빅데이터 자료 수집
## 파일 데이터셋 자료수집
## 웹 스크래핑
## 오픈 API 기반 자료수집
##
## 파일 데이터셋 자료수집
## - 파일 데이터 셋은 다양한 기관이 공익적인 목적에서 제공하는 
##   파일 데이터 셋을 통하여 자료를 수집
## - 일반적으로 파일 데이터셋은 정형데이터와 비정형데이터로 구분되며,
##   정형데이터는 CSV나 엑셀 파일 형식으로 제공, 비정형데이터는 텍스트파일로 제공
##
## 공공데이터 포털
## 주요서비스
## 데이터셋 : 파일데이터/오픈API/데이터시각화 검색 및 활용신청
##  활용사례 : 국내외 활용사례 및 가공된 데이터 공유


## 정형데이터 : CSV, 엑셀
## 엑셀 파일의 경우 엑셀에서 CSV파일로 변경하여 사용
# CSV 텍스트 파일 불러오기

library(readxl)
getwd()

data<- read.csv("./Data/전라남도_목포시_장애인_복지시설_20210802.csv",header = T, fileEncoding = "EUC-KR")
data


## 웹스크래핑
## 웹문서로부터 유용한 정보를 추출하는 기술
## 텍스트와 이미지가 혼합되어 있는 HTML형식으로 구성된 웹사이트에서 웹스크래핑을 통하여 정보를 추출
## 온라인 마켓의 상품 정보, 뉴스 기사

## 웹 스크래핑을 위한 필요 패키지
install.packages("rvest")  # 웹 스크래핑 패키지
install.packages("stringr") # 문자열 처리 패키지

library(rvest)
library(stringr)

## 웹스크래핑 문자
##  1.웹 스크래핑 대상 URL 할당
##  2.웹 문서 가져오기
##  3.특정 태그의 데이터 추출
##  4.데이터 정제
##  5.데이터 프레임 만들기
##
## 웹스 크래핑 예시
## 중고차 매매 사이트(보배드림)

## 1.웹 스크래핑 대상 URL 할당
url <- "https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1"
url

# 2.웹 문서 가져오기
usedCar <- read_html(url)
usedCar

# 3.특정 태그의 데이터 추출
# 가져온 usedCar에서 css가 ".product-item"인 것을 찾음.
carInfos <- html_nodes(usedCar, css = ".product-item")
head(carInfos)

# 차량 명칭 추출
title_tmp <- html_nodes(carInfos, css =".tit.ellipsis")
title_tmp


title <- html_text(title_tmp)
title


# 4.데이터 정제
title <- str_trim(title)  # 문자열에서 공백 제거
title

# 차량 연식 추출
year_tmp <- html_nodes(carInfos, css = ".mode-cell.year")
year_tmp

year <- html_text(year_tmp)
year

year <- str_trim(year)
year


# 연료 구분
title <- str_trim(title)  # 문자열에서 공백 제거
title

# 차량 연식 추출
fuel_tmp <- html_nodes(carInfos, css = ".mode-cell.fuel")
fuel_tmp

fuel <- html_text(fuel_tmp)
fuel

fuel <- str_trim(fuel)
fuel


# 주행거리 추출
km_tmp <- html_nodes(carInfos, css = ".mode-cell.km")
km_tmp

km <- html_text(km_tmp)
km

km <- str_trim(km)
km


# 판매가격 추출
price_tmp <- html_nodes(carInfos, css = ".mode-cell.price")
price

price <- html_text(price_tmp)
price

price <- str_trim(price)
price

price <- str_replace(price, '\n','') # 문자열 변경(\n을 스페이스로 변경)
price

# 차량 명칭으로부터 제조사 추출
maker = c()
maker

title

# 뛰어쓰기 기준으로 자른 다음 -> 리스트의 첫번째(maker 제조사)를 maker변수에 넣음음
for(i in 1:length(title)) {
  maker <- c(maker, unlist(str_split(title[i], ' '))[1])  # str_split 문자열 분리
}
maker


# 5.데이터프레임 만들기
usedcars <- data.frame(title, year, fuel, km, price, maker)
View(usedcars)

# 데이터 정제
# km 자료 숫자로 변경
usedcars$km

usedcars$km <- gsub("만km","0000", usedcars$km) # 문자열 변환
usedcars$km <- gsub("천km","000", usedcars$km)
usedcars$km <- gsub("km","", usedcars$km)
usedcars$km <- gsub("미등록","", usedcars$km)
usedcars$km <- as.numeric(usedcars$km) # 숫자형으로 변경

usedcars$km

# price 자료 숫자로 변경
usedcars$price

usedcars$price <- gsub("만원","",usedcars$price)
usedcars$price <- gsub("계약","",usedcars$price)
usedcars$price <- gsub("팔림","",usedcars$price)
usedcars$price <- gsub("금융리스","",usedcars$price)
usedcars$price <- gsub(",","",usedcars$price)
usedcars$price <- as.numeric(usedcars$price) # 숫자형으로 변경

usedcars$price


# 웹 스크래핑 자료 파일로 저장하기
# 디렉터리 설정
getwd()
write.csv(usedcars, "./Data/usedcars_new.csv")  # csv 파일로 저장하기
