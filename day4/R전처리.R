# R 데이터 전처리
## [Part1] read.csv로 한글이 있는 자료 open
setwd("C:/Sources/StuddyR/day4/참고교재 및 미션데이터전처리/data_r")
dir() 				# 현재 작업 디렉토리 가져오기
fileName ="cust_order_data.csv"
df=read.csv(fileName)
head(df)

# [미션. 1-1] 데이터 읽기전 메모리 모두 제거
## --- [코드작성]메모리 제거
rm(list = ls())
## --- [코드작성] 메모리에 있는 변수 확인(메모리 제거가 잘 되었는지 확인용)
ls()
setwd("C:/Sources/StuddyR/day4/참고교재 및 미션데이터전처리/data_r")
dir() 				
fileName ="cust_order_data.csv"
df=read.csv(fileName,sep='\t',encoding='ANSI')
df=read.csv('C:/Sources/StuddyR/day4/참고교재 및 미션데이터전처리/data_r/cust_order_data.csv',sep='\t',encoding='ANSI')
#[미션. 1-2] 총데이터의 갯수와 변수 성격 확인
## --- [코드작성] 총데이터의 갯수 (행과 열의 갯수 확인)
data.frame(table(df[,1]))
str(df)
nrow(df)
ncol(df)
## --- [코드작성] 각 변수의 성격확인(character, factor, num, int등)
# https://rsas.tistory.com/229   (팩터와 levels 에 관한 설명)
str(df)
## --- [코드작성] 위로 3개의 자료만 읽기
head(df,3)
## --- [코드작성] 변수명(필드명)만 출력
names(df)

[미션. 1-3] 아래의 2개 변수(필드)외에 나머지 변수에 대하여 해석
# CUST_SERIAL_NO: 고객번호
# SEX: 고객성별
# AGE: 고객나이
# REG_DATE : 현재시간
# ORDER_DATE : 물건주문날짜
# ORDER_HOUR : 물건주문시간
# ORDER_WEEKDAY : 물건주문요일
# IS_WEEKEND : 주말인가?
# GOODS_CODE : 물건코드번호
# LGROUP : LARGE 사이즈
# MGROUP : MEDIUM 사이즈
# SGROUP : SMALL 사이즈
# DGROUP :
# GOODS_NAME : 물건이름
# PRICE : 물건가격
# QTY : 물건구메수량


# [Part2] 자료 오류 확인
# 자료(데이터) 오류(데이터품질): 
# 각 필드별로 불필요한 자료셋이 포함되어 있는지를 확인하여 봄
# 아래의 데이터 구조 출력물에서도 쉽게 자료 오류를 확인할 수 있음

# [미션. 2-1] 결측치 확인 (참고R교재 33p-34p)
#---[코드작성] df의 전체 결측치 갯수 확인  (참고교재 33p)
sum(is.na(df))
table(is.na(df))
#---[코드작성] 각 변수별 결측치 갯수 확인 (참고교재 33p)
colName=names(df)
cnt=length(colName)
for (i in 1:cnt){
 print(colName[i])
 print(sum(is.na(df[,i])))		
}


# [미션. 2-2] 결측치 활용법 (참고교재 P35)
# GOODS_NAME값의 '#NAME?'를 NA로 대체하고 제거 하기 위하여
# ---[코드작성]  df$GOODS_NAME을 summary 하여서 #NAME?가 있는지를 확인하여 봄
summary(df$GOODS_NAME=='#NAME?')
#   Mode   FALSE    TRUE 
# logical  508347    2123 

#--- [코드작성] df$GOODS_NAME 에 자료가 '#NAME?' 인 자료만 
# subset으로 추출하여서 제거해도 되는 자료인지 확인하여 봄
a = subset(df, GOODS_NAME == '#NAME?')
head(a)
str(a)

#--- df$GOODS_NAME의 '#NAME?' 인 자료를 'NA' 로 변환하기전
#-- [코드작성] df$GOODS_NAME 의 NA갯수 확인
sum(is.na(df[,14]))

# --[코드작성] df$GOODS_NAME의 값이 #NAME?  인 자료에 NA값 할당
tmp<-df$GOODS_NAME
tmp[tmp =='#NAME?'] <-NA
tmp<-tmp[complete.cases(tmp)]
#-- [코드작성] df$GOODS_NAME 의 NA갯수 확인
sum(is.na(df))

# -- [코드작성] 결측치 시각화

head(df)

##############################################################
# 기술통계
setwd("C:/Sources/StuddyR/day4/참고교재 및 미션데이터전처리/data_r")
dir() 				
fileName ="cust_order_data.csv"
df=read.csv(fileName,sep='\t',stringsAsFactors = TRUE)
str(df)
tmp=data.frame(table(df[,1]))
head(tmp)
summary(tmp$Freq)
boxplot(tmp$Freq)

table(df[,5])


boxplot(df[,16])


hist(df[,16])
subset(tmp,tmp=='#NAME?')

tmp<-df$GOODS_NAME
tmp[tmp =='#NAME?'] <-NA
tmp<-tmp[complete.cases(tmp)]
str(tmp)
subset(tmp,tmp=='#NAME?')
sum(is.na(df[,14]))

tmp1=factor(as.character(tmp))
str(tmp1) 	# factor안에 있는 것은 지워도 남아있으니, character로 바꿔야 level이 다시들어온다



