# R 데이터 전처리
## [Part1] read.csv로 한글이 있는 자료 open
# [미션. 1-1] 데이터 읽기전 메모리 모두 제거
rm(list = ls())		## --- [코드작성]메모리 제거
ls()				## --- [코드작성] 메모리에 있는 변수 확인(메모리 제거가 잘 되었는지 확인용)
# df=read.csv('C:/Sources/StuddyR/day4/참고교재 및 미션데이터전처리/data_r/cust_order_data.csv',sep='\t',stringsAsFactors = TRUE)
df=read.csv('C:/Users/LG/Desktop/참고교재 및 미션데이터전처리/data_r/cust_order_data.csv',sep='\t',stringsAsFactors = TRUE)





#[미션. 1-2] 총데이터의 갯수와 변수 성격 확인
## --- [코드작성] 총데이터의 갯수 (행과 열의 갯수 확인)
data.frame(table(df[,1]))
nrow(df)		# 행의 수 : 510470
ncol(df)		# 열의 수 : 16
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
# LGROUP : LARGE 그룹
# MGROUP : MEDIUM 그룹
# SGROUP : SMALL 그룹
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
# 일정한 값을 결측치로 변경하고 결측치 제거 명령어를 이용하여 행을 제거하기도 함.
# Size<-data$sizeOfsite 	-자료의 일정변수를 Size 변수에 할당
# Size [Size>10000]<-NA 	-Size값이 >10000 이상인 자료는 NA로 할당
# Size<-Size[complete.cases(Size)] 	-NA가 있는 값 제거
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
a

#--- df$GOODS_NAME의 '#NAME?' 인 자료를 'NA' 로 변환하기전
#-- [코드작성] df$GOODS_NAME 의 NA갯수 확인
sum(is.na(df[,14]))

# --[코드작성] df$GOODS_NAME의 값이 #NAME?  인 자료에 NA값 할당
tmp<-data.frame(table(df[,14]))
tmp[tmp =='#NAME?']<-NA

#-- [코드작성] df$GOODS_NAME 의 NA갯수 확인   (참고교재 32p의 2번)
head(tmp)
sum(is.na(tmp))


# -- [코드작성] 결측치 시각화
# install.packages('ggplot2')
# library(ggplot2)
boxplot(tmp$Freq)
hist(tmp$Freq)

library(Amelia)
tmp<-df$GOODS_NAME
tmp[tmp =='#NAME?']<-NA
tmp=t(tmp)
str(tmp)
head(tmp)
missmap(tmp)



# ---- NA가 있는 자료 제거
tmp<-data.frame(table(df[,14]))
tmp[tmp =='#NAME?']<-NA
tmp = tmp[complete.cases(tmp),]

# ---- #NAME? 라는 글자가 있는지 갯수 확인
nrow(subset(df,df$GOODS_NAME=='#NAME?'))

# ---- [코드작성] 결측치 시각화를 통해 NA값이 모두 제거 되었는지 확인
boxplot(tmp$Freq)
hist(tmp$Freq)
head(tmp)
str(tmp)


##############################################################
# 풀이
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




################################################################################
# [factor의 요인값 제거하여도 levels 값은 변경되지 않음. ]
# str(df) 를 수행하여 보면 여전히 GOODS_NAME levels 에 '#NAME?' 가 있음
# 레벨 제거 하기 위하여서 패키지를 사용해야함
# 구글검색 ' R 레벨 제거'
# http://aispiration.com/data-science/ds-factor-stat545.html
# 쉽게 하는 방법은 charater로 형변한후 다시 factor로 변환하면 됨
str(df)   # 자료보면 14번 열의 GOODS_NAME에 #NAME? 존재함.
class(df[,14])    # factor로 나옴
df[,14]=factor(as.character(df[,14]))  # 문자열로 변경후 다시 factor함.(factor은 필요하면 함)
class(df[,14])  # 확인해보면 다시 factor 되어 있음
str(df)   # df[,14] 에 #NAME? 없어짐

# 확인
tmp<-df$GOODS_NAME
tmp[tmp =='#NAME?'] <-NA
tmp<-tmp[complete.cases(tmp)]
str(tmp)
subset(tmp,tmp=='#NAME?')
sum(is.na(df[,14]))

tmp1=factor(as.character(tmp))
str(tmp1) 	# factor안에 있는 것은 지워도 남아있으니, character로 바꿔야 level이 다시들어온다









# [ df의 모든 factor를 character로 변경하고자함]
# 아래는 GOODS_NAMES의 #NAME? 를 제거하기 전 자료임
# 아래 자료에 보면 * 표시는 #NAME? 를 제거한 작업을 했을때 일부분은 삭제됨
# 하지만 str(df)를 해보면 여전히 AGE등에 levels로 * 표시가 남아있음
# 이경우는 * 이 모두 제거되었지만 levels에 남아있거나 (character후 다시 factor로 변환하면 확인됨)
# '*' 이 있는 자료가 실제 남아 있는 경우(unique로 확인해보면됨)
# levels 값의 변화를 위해
# 모든 factor형을 character로 변환하여 levels를 조정하여 확인하고자함.
# 참고 type확인: class(df[,1])
# 구글 검색  R에서 if
cnt=length(df)

for (i in 1:cnt) {
    if (class(df[,i])=='factor'){
        df[,i]=as.character(df[,i])
        }
}
str(df)


# 다시 factor로 변환해서도 levels에 '*' 이 있는 경우는 unique로 '*' 표시가 실제 있다는 뜻
cnt=length(df)

for (i in 1:cnt) {
    if (class(df[,i])=='character'){
        df[,i]=as.factor(df[,i])
        }
}
str(df)



## 위의 자료 형 변환전에 이 과정을 먼저 진행해도 됨
## 자료값에 실제로 '*' 이 있음이 확인됨
colNum=c(2,3,4,6,7)
for (i in colNum){
    print(paste('---------------', i, '번째컬럼: 컬럼명은 ', names(df)[i]))
    print(unique(df[,i]))
    cat('\n')    # 한줄 띄는 명령어는 cat으로 사용해야함.  
       #https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=dic1224&logNo=80206919335
}




## '*' 이 있는 자료 제거는
# 방법1: '*' 표시가 있는 자료를 NA로 변경하고, NA값 제거
# 방법2: '*' 표시가 없는 자료만 다시 별도로 제작
# 여기서는 방법2로 작업
df2=subset(df,df[,2]!='*')
colNum=c(2,3,4,6,7)
for (i in colNum){
    print(paste('---------------', i, '번째컬럼: 컬럼명은 ', names(df)[i]))
    print(unique(df2[,i]))
    cat('\n')    # 한줄 띄는 명령어는 cat으로 사용해야함.  
       #https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=dic1224&logNo=80206919335
}













# [Part3] 문자 자료 날짜자료로 변환후 파생변후(년,월,요일등제작)
# ORDER_DATE 변수(필드)를 chr 또는 factor에서 Date로 형변환
# Date로 형 변환되면 년, 월, 일, 요일등을 쉽게 제작할수 있음
# [미션. 3-1] 형변환
## -[코드제작]  df2$ORDER_DATE 필드를 날짜형식으로 변경하여 tmp  변수에 할당하여 class로 type 확인
#  구글검색 ' R에서 문자자료 날짜 변환'
tmp<-as.Date(df2$ORDER_DATE)		## - df2$ORDER_DATE에 tmp 자료 할당
class(tmp)					## - 데이터 구조확인하여서 ORDER_DATE 에 Date 나오는지 확인


# [미션. 3-2] Date 형식 자료 년,월,일,요일 제작
# lubridate 패키지를 설치한뒤, 도움말 또는 구글검색
# year, month 파생변수 제작 (요일은 ORDER_WEEKDAY 에 있음)
install.packages("lubridate")
library(lubridate)

df2$year=year(df2$ORDER_DATE)
df2$month=month(df2$ORDER_DATE)

head(df2)

str(df2)



# [미션. 3-2] 성별의 F는 'female' / M은 'male'로 변환하여 새로운 gender 변수생성
## - df2자료에서 다시한번더 확인 
unique(df2[,2])			# - unique명령으로 F,M만 존재하는지 확인



subset(df2, df2[,2]=='*') 	# - subset명령으로 df2[,2]자료에 '*'없음 확인

table(df2[,2])			#- table 명령으로 F,M의 빈도수(도수분포) 계산


# -- [코드제작] df$gender = ifelse 명령으로 F이면 'female',  그외는 male로 할당
## 참고 교재 27p
str(df2)
df3=ifelse(df2$SEX=='F','female','male')
head(df3)
# 위로 6개의 자료 보기





# [Part5] 데이터셋 구성하여 저장
# 성별구매건수
# - [코드제작] gender 변수에 할당 =>16:19번째의 열 컬럼만 별도로 구성하여서
# --[코두제작]  tmp1에 성별,구매건수의 총합
tmp1<-table(df2[,2])
tmp1


# 참고교재 40p
# --[코드제작] tmp2에 성별, 구매건수의 합의 비율
tmp2<-prop.table(tmp1)
tmp2





# 참고교재 41p
tmp3=rbind(tmp1,tmp2)
rownames(tmp3)=c('total','prop')
tmp3

# 참고교재 41p
# --[코드제작]  tmp3의 행단위의 합

tmp4=apply(tmp3,1,sum)
tmp4


# --[코드제작]  tmp4에 월별 성별 빈도수(몇번 나왔나)
# 참고교재 41p

# -- 월별, 구매건수의 총합
tmp=split(gender.Qty$QTY, gender.Qty$month)
sapply(tmp,sum)




