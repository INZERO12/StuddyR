# 전국무인교통단속카메라표준데이터
setwd("C:/Sources/StuddyR/day2")
dir() 				# 현재 작업 디렉토리 가져오기
fileName ="전국무인교통단속카메라표준데이터.csv"
df=read.csv(fileName)
head(df)
str(df)
barplot(table(df$시도명))



## 01, 03, 10, 9 확인 필요
a = subset(df, 시도명 == '01')
head(a)
str(a)

## 시군구명이 과연 '서초구'만 있는가
summary(factor(a$시군구명))
table(tmp$시군구명)
unique(a$시군구명)


a = subset(df, 시도명 == '03')
head(a)
str(a)

## 시군구명이 과연 '대구광역시 중구'만 있는가
summary(factor(a$시군구명))
table(tmp$시군구명)
unique(a$시군구명)




a = subset(df, 시도명 == '9')
head(a)
str(a)

## 시군구명이 과연 '경기도 가평군'만 있는가
summary(factor(a$시군구명))
table(tmp$시군구명)
unique(a$시군구명)




a = subset(df, 시도명 == '10')
head(a)
str(a)

## 시군구명이 과연 '강원도 양구군'만 있는가
summary(factor(a$시군구명))
table(tmp$시군구명)
unique(a$시군구명)


# factor는 명목형변수일때 -> 집계할 것 / 카운팅해야 할 만큼 명목있는 자료에 사용
-----------------------------------------------------------------------------
setwd("C:/Sources/StuddyR/day2")



dir() 				# 현재 작업 디렉토리 가져오기
fileName ="전국무인교통단속카메라표준데이터.csv"
df=read.csv(fileName)
head(df)
str(df)

#################################################
### factor는 명목형변수일때 -> 집계할 것 / 카운팅해야 할 만큼 명목있는 자료에 사용
### 데이터 형 변환
### 1. character를 factor로 변환
### ex) 시도명, 시군구명, 도로종류, 설치연도, 도로노선명, 제한속도
### 
### 2. 숫자를 factor로 변환하는 파생변수 
### 자주사용(명목형)일때 factor로 바꾸면 좋다
### 설치연도, 제한속도
#################################################
### csv 맨위는 필드명이 아니라, 타이틀명이다 -> names로 이름을 바꿔야함

df$시도명 = factor(df$시도명)
df$시군구명 = factor(df$시군구명) # df[,3]=factor(df[,3])과 같다, 위치값으로 부를때 빠름
df[,4]=factor(df[,4])
df[,6]=factor(df[,6]) # 이 작업을 하면 levels 생김 => 카운트 가능
str(df)
summary(df) # 확인
levels(df[,2])




df$설치연도Factor = factor(df$설치연도)	### 숫자를 factor로 변환하는 파생변수 만들기
						### 설치연도Factor추가되서 변수 24개됨 / 이전엔 23개
str(df)		# data.frame':   19581 obs. of  24 variables => 24개의 변수, 19581개 데이터
df[,25]=factor(df$제한속도)			### 숫자를 factor로 변환하는 파생변수 만들기
str(df)						### 파생변수 추가되서 변수 25개됨 확인

summary(df)
plot(df[,24])	# 연도별 무인카메라설치 그래프 => 
		# ex) 2012년에 줄어듬을 알 수 있다 => 2012년에 무슨일이 있었을까?

table(df[,25])	# 제한속도의 데이터셋


#####################################################
### 복습용 176쪽 매트릭스 구조가 필요한 이유
#####################################################
str(df)

ma=df$제한속도
dim(ma)
ncol(ma)
nrow(ma)	### 가로세로 데이터가 아니라서 결과 모두 NULL
length(ma)	### 그냥 데이터 하나
mean(ma)	### 이럴경우 mean이나 sum 상관 없음



ma=df[,c(10,11)] # 위도, 경도
head(ma)
colSums(ma)	# Na 나옴
rowSums(ma)	# 결과나옴


#########################################################
### 2. 컬럼명 정리
### names(df) 작업했해서 인덱싱번호에다가 컬럼명변경
### names(df)=c('','',)....
#########################################################
names(df)[1]='카메라Num'
names(df)[25]='제한속도factor'
names(df)

# names(df)[1]=names(df)[1]+'bu'	# R은 문자열 연결은 +로 못함	
paste("c","k",sep='')			# R 문자열 연결
paste0("c","k")			# R 문자열 연결2
names(df)[1]=paste(names(df)[1],'bu',sep='')	# 카메라Numbu
str(df)




#########################################################
### 3. 필요한 컬럼만 모아서 별도의 데이터셋 제작
### 첫번째 : 불필요한 컬럼을 제거함으로서 수행속도를 높임
### 참고) 제거란? 쓰고자하는것만 모으는것
### 두번째 : 분석하고자 하는 내용에 맞게끔 새로운 데이터프레임 구성
###
#########################################################
names(df)		# 번호 빨리알수있다
df1=df[,c(2,3,4,7,11,13,14,16)]
str(df1)
df2=df[c(10,11,13,14)]	# 위경도로 지도그리고 싶다면
str(df2)




#########################################################
### 4. 조건에 맞는 자료만 필터링 해서 새로운 데이터셋 제작
### subset으로
#########################################################
str(df1)
# 미션, 단속구분을 unique하게 받아봄
unique(df1$단속구분)	# 단속구분에 해당하는 데이터셋을 

# subset을 이용하여 단속구분이(chr) 1인 자료만 필터링 해보세요
subset(df1, 단속구분 == '1')
head(subset(df1, 단속구분 == '1'))

# subset을 이용하여서 제한속도(int)가 50인 자료만 필터링
str(df1)
subset(df1, 제한속도 == 50)
head(subset(df1, 제한속도 == 50))

# subset을 이용하여서 단속구분이 1제외하고 필터링
subset(df1, 단속구분 != '1')
head(subset(df1, 단속구분 != '1'))

# 교재 179p 참조(두 개의 조건 모두 만족은 And연산(&) / 두개중 한개만 만족해도 되면 OR(|))
# subset을 이용하여 단속구분이 1이면서 (&) 시군구명이 '경기도'인 자료
# subset(df1, 단속구분 == '1') & subset(df1, 시도명 == '경기도')

시도.경기도 = subset(df1, 시도명 == '경기도')
table(df1$시군구명)


#########################################################
### 5. 자료셋을 새로 제작해서 csv로 저장하기
### 
#########################################################
unique(df1$시도명)

부산=subset(df1,시도명=='부산광역시')
unique(부산$시군구명)

sido=unique(df1$시도명)
sido
index=1
tmp=subset(df1,시도명==sido[index])
head(tmp)
#   시도명 시군구명 도로종류 도로노선방향     경도 단속구분 제한속도 과속단속구간길이
# 1 경기도   시흥시     시도            3 126.7093        2       50               NA
# 2 경기도   시흥시     시도            3 126.7116        2       50               NA
# 3 경기도   안산시 일반국도            3 126.8369        2       60               NA
# 4 경기도   안산시     시도            3 126.8208        2       60               NA
# 5 경기도   안성시     시도            3 127.2425        2       60               NA
# 6 경기도   수원시     시도            3 127.0306        2       50               NA
# ㄴ이곳을 rownames라고 한다 / 인덱스 번호 

select = '경기도'
tmp = subset(df1,시도명==select) # 위에 코드랑 같음

index=1
tmp=subset(df1,시도명==sido[index])
fileName = paste(sido[index],'.csv',sep='')
write.csv(tmp,fileName)

index=2
tmp=subset(df1,시도명==sido[index])
fileName = paste(sido[index],'.csv',sep='')
write.csv(tmp,fileName)

index=3
tmp=subset(df1,시도명==sido[index])
fileName = paste(sido[index],'.csv',sep='')
write.csv(tmp,fileName)


### for 이용한 방법
sido==unique(df1$시도명)
cnt=length(sido)

for(index in 1:cnt){
tmp=subset(df1,시도명==sido[index])

fileName = paste('C:/Sources/StuddyR/day2/저장/',sido[index],'.csv',sep='')
write.csv(tmp,fileName)
}




names(df1)
colbunho=2
folderName = paste('C:/Sources/StuddyR/day2/저장/',names(df)[colbunho],sep='')
dir.creat(folderName)

### 새로운 폴더 제작
dir.create(paste0("C:/Sources/StuddyR/day2/저장/",'new'))

tmp = names(df1) 	#tmp는 임시변수
findCol = tmp[index]	#findCol이라는 필드명
findCol

폴더명 = paste('C:/Sources/StuddyR/day2/저장/',findCol,'/',sep='') 지
dir.create(폴더명)
### '/'주는이유 : 이름이상하게 저장되는거 방
##################################################################
tmp=names(df1)
index = 7
findCol = tmp[index]
# tmp = unique(df1[,index])	# findCol = tmp[index]의 index와 같다
# head(unique(df1[,1]))

폴더명 = paste('C:/Sources/StuddyR/day2/저장/',findCol,'/',sep='') 지
dir.create(폴더명)


dataList=unique(df[,index])
for (index2 in 1:length(dataList)){
	tmp=subset(df1,df[,index]==index2)
	fileName = paste(폴더명,index2,'csv',sep='')
	write.csv(tmp,fileName)}

#######for 사용#####
tmp=names(df1)
length(tmp)
for(index in 1:length(tmp)){
findCol = tmp[index]

폴더명 = paste('C:/Sources/StuddyR/day2/저장/',findCol,'/',sep='') 지
dir.create(폴더명)

dataList=unique(df[,index])
for (index2 in 1:length(dataList)){
	tmp=subset(df1,df[,index]==index2)
	fileName = paste(폴더명,index2,'csv',sep='')
	write.csv(tmp,fileName)}

###################################################################
### 자료를 새로 불러왔을때, 이 자료를 가지고 문서를 만드는것
### re(list=Is()) => 메모리 삭제
###################################################################

rm(list = ls())
ls()
setwd("C:/Sources/StuddyR/day2")
dir() 				# 현재 작업 디렉토리 가져오기
fileName ="전국무인교통단속카메라표준데이터.csv"


###################################################################
### 데이터로드 후 재작업해서 다시 로드
### 데이터의 문자열을 모두 팩터로 읽기=> stringsAsFactors=TRUE
######################################################################
df=read.csv(fileName,stringsAsFactors=TRUE) # df=read.csv(dir()[index],stringsAsFactors=TRUE)와 같다
head(df)
str(df)
df1=df[,c(1:9)]	# df의 1~9번열만 df1에 할당
df1자료를 작업자료.csv로 저장
write.csv(df1,'작업자료.csv')
# 메모리변수모두 제거
rm(list = ls())
setwd("C:/Sources/StuddyR/day2")
dir() 				# 현재 작업 디렉토리 가져오기
df=read.csv('작업자료.csv',stringsAsFactors=TRUE)
df=df[,-1]	# 밑에 X 없애기 위해 사용
str(df)


###################################################################
### 기술통계
######################################################################
summary(df)
#       X         무인교통단속카메라관리번호        시도명        시군구명    
# Min.   :    1   1      :   70              경기도    :5767   고양시 :  707  
# 1st Qu.: 4896   2      :   56              서울특별시:1794   성남시 :  461  
# Median : 9791   3      :   55              경상남도  :1787   강남구 :  369  
# Mean   : 9791   4      :   55              충청남도  :1638   평택시 :  334  
# 3rd Qu.:14686   6      :   55              경상북도  :1367   서초구 :  330  
# Max.   :19581   5      :   54              전라남도  :1049   서구   :  327  
#                 (Other):19236              (Other)   :6179   (Other):17053  
# X는 첫 열의 숫자 index


names(df)[2]; class(names(df[2])) ### 또는 str(names(df[2]))
summary(df[,2])
data.frame(빈도수=summary(df[,2]))

###################################################################
### 기술통계
######################################################################
### NA값 확인
sum(is.na(df[,1]))	# NA값 0개
sum(is.na(df[,2]))	# NA값 0개
sum(is.na(df[,3]))	# NA값 0개
sum(is.na(df[,4]))	# NA값 0개
sum(is.na(df))		# 전체 NA값 930개 => 어디에 na있는지 모름 => 시각화 필요

# for문을 이용한 na개수 세기
colName=names(df)
cnt=length(colName)
for (i in 1:cnt){
 print(colName[i])
 print(sum(is.na(df[,i])))		# 도로노선방향에 na값 930개
}


## NA(결측치)개수 시각화
# 결측치 패키지
# install.packages('naniar')		# 패키지 설치
# library(naniar)			# 라이브러리 불러오기
naniar::miss_case_summary(df) 	# case : 행 기준
naniar::miss_var_summary(df)		# variable : 변수 기준

naniar::vis_miss(df)			# 결측치 시각화1
naniar::gg_miss_var(df)		# 결측치 시각화2



# install.packages('VIM')
# library(VIM)
library(VIM); VIM::aggr(df)		# 결측치 시각화3


install.packages('Amelia')
library(Amelia)
missmap(df)				# 결측치 시각화4(가장기본)

savePlot("무인카메라결측치4",type="png")	# plot창을 "무인카메라결측치" 이름으로 png파일로 저장

# 결측치 제거
df = na.omit(df)
missmap(df)
str(df)

####### 시도명 그래프
tableDf=data.frame(table(df[,2]))
names(tableDf)[1]='title'
plot(tableDf)


tableDf=data.frame(table(df[,4]))
names(tableDf)[1]='title'
tableDf$pro=tableDf$Freq/sum(tableDf$Freq)*100
tableDf

#######################################################
### 그룹별 적용
### apply() : 2차원 데이터를 행, 열 방향으로 연산
### 적용방향 = 1:같은 행별, 2:같은 열별, c(1,2): 원소별
#######################################################
#### 원소별 적용
#### sapply() : 벡터에 함수를 반복 적용(벡터로 출력)
#####################################################
####그룹별 연산 
####tapply() : 그룹별 연산
#########################################################3



##### 시도별 도로노선방향의 평균
tmp = split(df$도로노선방향,df$시도명)
tmp[[1]]	# 01(경기도) 자료
head(tmp)	# 01(경기도) 자료라는것 확인
data.frame(sapply(tmp,mean))	# 평균으로 묶어달라

tapply(df$도로노선방향,df$시도명,mean) # 테이블 구조
