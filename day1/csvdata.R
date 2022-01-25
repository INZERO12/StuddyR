# 공공데이터 활용
# 1. 작업자료 다운(부산광역시_현대미술관 관람객 수)
# 2. R에서 csv로 읽기 => df = read.csv('.....csv')
# 3. 구조파악 => str(df) : 타입, 행, 열의갯수
# 4. 데이터샘플을 확인 => head(df,10)
# 5. 데이터의 기본 기술통계 => summary(df)
# 6. 빈도수계산 => summay(factor(df[,1]) : summary를 factor화하면 갯수를 셀수 있다

# 콘솔창에 커서를 두고 파일-작업디렉토리변경/ setwd로 작업디렉토리 설정할 수 있음

dir()		# 파이썬 os.listdir 또는 glob와 같다


df = read.csv("부산광역시_현대미술관 관람객 수1_20201231.csv")
dir()[2]	# 디렉토리의 2번째 파일
str(df)  	# data.frame
head(df)	# 상위 5개의 데이터만 나옴
names(df)	# "연도"  "월"   "관람객수 => csv자료의 가장 윗자료를 필드명으로 가져옴

summary(df) 
#      연도            월           관람객수     
# Min.   :2018   Min.   : 1.00   Min.   :  2817  
# 1st Qu.:2018   1st Qu.: 3.75   1st Qu.:  7345  
# Median :2019   Median : 6.50   Median : 31048  
# Mean   :2019   Mean   : 6.50   Mean   : 41782  
# 3rd Qu.:2020   3rd Qu.: 9.25   3rd Qu.: 48205  
# Max.   :2020   Max.   :12.00   Max.   :200868  
#                                NA's   :17 		# NA값 => 없는 값(결측치)

# 자료 연도만 출력
str(df)
df[,1]	# df$연도 과 같다
min(df[,1])
max(df[,1])

# 미션) 연도와 관람객수만 출력
# 미션) 위로 12개의 자료만 출력, 즉 2018년도 자료가됨
# 미션) 아래로 12개의 자료만 출력, 즉 20020년도 자료
# 미션) 2018년도 울과 관람객수만 출력

df[,c("연도","관람객수")]
head(df,12)
tail(df,12)
head(df[,c("연도","관람객수")])

# NA(결측치)값 0으로
summary(df)
is.na(df[3]) # 관람객의 True False 확인
table(is.na(df[3])) # table은 집계명령어



# 필드에 대한 제목 주석
par(mfrow=c(3, 1))	# 차트창을 닫거나, 만날때까지 유지
barplot(table(is.na(df[1])),main = '연도')
# title("연도")
barplot(table(is.na(df[2])),main = '월')
# title("월")
barplot(table(is.na(df[3])),main = '관람객수')
# title("관람객수")


# 위에꺼와 같다 => for 활용 가능
par(mfrow=c(3, 1))
index = 1
barplot(table(is.na(df[3])),main = names(df[index]))
index = 2
barplot(table(is.na(df[3])),main = names(df[index]))
index = 3
barplot(table(is.na(df[3])),main = names(df[index]))


# 참고 for문
par(mfrow=c(3, 1))
for(i in 1:3){
i=i+1
barplot(table(is.na(df[3])),main = names(df[index]))
}


# R 차트저장
getwd()
# ------------------------------------------------------------------------
# 정리
# 1. csv 자료를 읽기위해서 작업경로를 세팅
#	콘솔창에 커서를 두고 [파일-작업디렉토리변경]    R에서는 setwd('경로명')으로 작업디렉토리 변경가능
# 2. dir() 을 이용하여 파일리스트 확인
# 3. df = read/csv 명령어로 자료를 읽음
	(별도옵션없었기 때문에 가장상단은 제목, 문자는 factor로 읽음)
# 4. 데이터셋 샘플 확인(위로 head, 아래로 tail)
# 5. 데이터의 구조를 확인(필드명, 성격을 확인등)
# 6. 기술통계를 통하여서 데이터셋의 분포를 확인
	summary(df)모든 데이터 확인과 
	summary(df[,c(1,3)]), summary(df[,c(3:12)])처럼 일부 데이터만 확인도 가능
# 7. NA값을 반드시 확인(summary확인, is.na(df), table(is.na(df))), barplot(table...))
# 8. 참고: 시각화도 가능
summary(df)
par(mfrow=c(3, 1))  #차트창을 닫거나, 
          # par(mfrow=c(1,1))만날때까지 유지
index=1
barplot(table(is.na(df[index])),main=names(df)[index])
index=2
barplot(table(is.na(df[index])),main=names(df)[index])
index=3
barplot(table(is.na(df[index])),main=names(df)[index])

# 9. NA값을 처리 (0으로 대체, 중앙값이나 평균값으로 대체, 0있는 행을 모두 제거, 임의값대체)
df[is.na(df)]=0
summary(df)
par(mfrow=c(3, 1))  #차트창을 닫거나, 
          # par(mfrow=c(1,1))만날때까지 유지
index=1
barplot(table(is.na(df[index])),main=names(df)[index])
index=2
barplot(table(is.na(df[index])),main=names(df)[index])
index=3
barplot(table(is.na(df[index])),main=names(df)[index]
#-------------------------------------------------------------------------
# 10. 2018년도 자료가 12개, 2019가 12개, 202년도가 12개가 나오나
#	빈도수 확인 => factor, table
#	summary(factor(df$연도)) 또는 table(df$연도) 또는 barplot(table(df$연도))
# 11. 1월, 2월, 3월~12월달 자료가 각 3개씩 나오나
# -------------------------------------------------------------------------
#### 년도별 월의 관람객수를 차트로 표시하고자 함
#### 년도별로 자료를 먼저 나누어야함. R에서는 split를 이용하여 손쉽게 조건에 맞는 자료를 나눌수 있음

# 12.  year=split(df,df$연도)         # df의 년,월,관람객수를 df$년의 unique한 값으로 나눔
# 13.  year                               # year[[1]]  은 2018년도 / year[[2]]는 2019년도   / year[[3]]은 2020년도 자료가 있음.
# 14.  par(mfrow=c(3, 1))

# 15. index=1
# 16.  yearData=year[[index]]
# 17.  yearData                                          # 해보면 2018 년도 자료만 있음.  summary(yearData) ,     table(yearData[,1])
# 18.  title=year[[index]][1,1]                            # year[[1]]은 2018년도 의 연도, 월, 관람객수 ,    그중 [1,1]은 1행1열  1열은 연도니까 가장 위에 있는 연도 자료임
                                                                # 15~19번 처럼 하는 이유는 나중에 for로 만들기 위한 인덱싱 작업임. 직접 title='2018년도 자료' 해도 됨.
# 19.  plot(yearData$월, yearData$관람객수, main=title)

# ----15,16번,18,19번 반복   (2019년도 자료)
index=2 ;  yearData=year[[index]]; title=year[[index]][1,1] 
plot(yearData$월, yearData$관람객수, main=title)

# ----15,16번,18,19번 반복  (2020년도 자료)
index=3 ;  yearData=year[[index]]; title=year[[index]][1,1] 
plot(yearData$월, yearData$관람객수, main=title)
# test
