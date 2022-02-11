## *오픈 API 기반 자료수집
## 다수의 기관에서 오픈 API를 통하여 해당 기관들이 보관하고 있는 자료들을 대부분
## REST 방식을 통하여 제공
## 오픈 API 활용동작
## 1. 오픈 API 자료요청
## 2. 자료 형식 변경
## 3. 요구된 자료 전송

## 오픈 API로 가져온 자료를 XML 형식으로 변경하는데 사용되는 함수들을 지원하는 "XML" 패키지
install.packages("XML")
library(XML)


## 오픈 API 근간의 자료수집 순서
## 1. 오픈 API 제공 웹사이트에 접속 및 로그인
## 2. 오픈 API 자료 검색
## 3. 활용신청 및 개발계정 API키 신청
## 4. 승인 받은 개발계정 API키 확인
## 5. 오픈 API접속을 위한 웹 URL 및 요청변수 확인
## 6. R에서 오픈 API를 이용한 자료요청
## 7. 데이터프레임 만들기



## 웹사이트 URL 설정
api_url <- "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty"


# 승인 받은 KEY 등록
service_key <- "0H98qN48SQeAPqUadJotGoDtLnv%2FPCpwdL9wlR6PZqMwMFLWBBcEamLFTHEhR2dSzYkuo8j%2BuKpflSM9gYFyrg%3D%3D"

# 요청 변수 등록
numOfRows <- "30"
sidoName <- "경기"

sidoName <- URLencode(iconv(sidoName, to="UTF-8")) # 한글을 웹 URL 코드화
sidoName


searchCondition <- "DAILY"


# 오픈 API URL
# paste와 paste0의 차이
paste("a","b","c") # 공백을 구분자로 묶기
# paste("a","b","c", sep="") # 원래는 이상태
# paste("a","b","c", sep="/") # 공백 대신 특수문자로 구분 가능
paste0("a","b","c") # 구분자 없이 모두 묶기

# URL 주소를 공백없이 모두 묶기
open_api_url <- paste0(api_url,"?serviceKey=",service_key,
                       "&numOFRows=", numOfRows,
                       "&sidoName=",sidoName,
                       "&searchCondition=",searchCondition)
open_api_url


# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data <- xmlTreeParse(open_api_url,
                         useInternalNodes = TRUE,
                         encoding = "utf-8")
raw.data




# XML 형식의 자료를 데이터프레임으로 변경하기
# </item> 태그 별로 데이터 구분하기
air_pollution <- xmlToDataFrame(getNodeSet(raw.data,"//item"))
air_pollution

View(air_pollution)

# subset() : 데이터프레임 내에서 검색 조건(select)에 맞는
#              항목(컬럼)들만 가지고 오기
air_pollution <- subset(air_pollution,
                        select = c(dataTime,     # 측정일
                                   stationName,  # 측정소명
                                   so2Value,     # 아황산가스 지수
                                   coValue,      # 일산화탄소 농도
                                   o3Value,      # 오존 농도
                                   no2Value,     # 이산화질소 농도
                                   pm10Value))   # 마세먼지 농도
View(air_pollution)



# 오픈 API 자료 파일로 저장하기
# 디렉터리 설정
getwd()
write.csv(air_pollution,"./Data/air_pollution_new.csv")  # csv 파일로 저장



###############################################################################
# 코로나-19관련 병원 운영기관 목록
## 웹사이트 URL 설정
api_url2 <- "http://apis.data.go.kr/B551182/pubReliefHospService/getpubReliefHospList"


# 승인 받은 KEY 등록
service_key2 <- "0H98qN48SQeAPqUadJotGoDtLnv%2FPCpwdL9wlR6PZqMwMFLWBBcEamLFTHEhR2dSzYkuo8j%2BuKpflSM9gYFyrg%3D%3D"

# 요청 변수 등록
numOfRows <- "100"
spclAdmTyCd <- "A0" # 국민안심병원
pageNo <- "1"
spclAdmTyCd <- URLencode(iconv(spclAdmTyCd, to="UTF-8")) # 한글을 웹 URL 코드화
spclAdmTyCd





# 오픈 API URL
# paste와 paste0의 차이
paste("a","b","c") # 공백을 구분자로 묶기
# paste("a","b","c", sep="") # 원래는 이상태
# paste("a","b","c", sep="/") # 공백 대신 특수문자로 구분 가능
paste0("a","b","c") # 구분자 없이 모두 묶기

# URL 주소를 공백없이 모두 묶기
open_api_url2 <- paste0(api_url2,"?ServiceKey=",service_key2,
                        "&pageNo=", pageNo,
                        "&numOfRows=",numOfRows,
                        "&spclAdmTyCd=",spclAdmTyCd)
open_api_url2


# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data2 <- xmlTreeParse(open_api_url2,
                          useInternalNodes = TRUE,
                          encoding = "utf-8")
raw.data2




# XML 형식의 자료를 데이터프레임으로 변경하기
# </item> 태그 별로 데이터 구분하기
covid_hospital <- xmlToDataFrame(getNodeSet(raw.data2,"//item"))
covid_hospital

View(covid_hospital)




# 오픈 API 자료 파일로 저장하기
# 디렉터리 설정
getwd()
write.csv(covid_hospital,"./Data/covid_hospital2_new.csv")  # csv 파일로 저장

# 항목명 변경
library(plyr)
covid_hospital <- rename(covid_hospital,
                         c(adtFrDd= "운영가능일자",
                           hospTyTpCd = "선정유형",
                           sgguNm = "시군구명",
                           sidoNm = "시도명",
                           spclAdmTyCd = "구분코드",
                           telno = "전화번호",
                           yadmNm = "기관명"))

covid_hospital

# 서울 병원만 뽑기
seoul_hos <- covid_hospital %>%
  filter(시도명 == "서울")


seoul_hos

###############################################################################
# 보건복지부_코로나19연령별,성별감염_현황 조회 서비스
## 웹사이트 URL 설정
api_url3 <- "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19GenAgeCaseInfJson"


# 승인 받은 KEY 등록
service_key3 <- "0H98qN48SQeAPqUadJotGoDtLnv%2FPCpwdL9wlR6PZqMwMFLWBBcEamLFTHEhR2dSzYkuo8j%2BuKpflSM9gYFyrg%3D%3D"

# 요청 변수 등록
numOfRows <- "100"
pageNo <- "1"
startCreateDt <- "20220201"
endCreateDt <- "20220211"



# URL 주소를 공백없이 모두 묶기
open_api_url3 <- paste0(api_url3,"?serviceKey=",service_key3,
                        "&pageNo=", pageNo,
                        "&numOfRows=",numOfRows,
                        "&startCreateDt=",startCreateDt,
                        "&endCreateDt=",endCreateDt)
open_api_url3


# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data3 <- xmlTreeParse(open_api_url3,
                          useInternalNodes = TRUE,
                          encoding = "utf-8")
raw.data3




# XML 형식의 자료를 데이터프레임으로 변경하기
# </item> 태그 별로 데이터 구분하기
covid_genage <- xmlToDataFrame(getNodeSet(raw.data3,"//item"))
covid_genage

View(covid_genage)




# 오픈 API 자료 파일로 저장하기
# 디렉터리 설정
getwd()
write.csv(covid_genage,"./Data/covid_genage_new.csv")  # csv 파일로 저장





