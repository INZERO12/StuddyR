# 자료_장바구니분석테스트
install.packages("arules")
library(arules)
setwd("C:/Sources/StuddyR/day4") # 디렉토리는 상황에 맞추어서 세팅
dir()
tr<-read.transactions ("자료_장바구니분석테스트.txt",format="basket",sep=",")
tr 

#지지도, 향상도 0.1 이상 자료 (0.1은 10%를 의미함 숫자값은 사용자가 임의로 넣음)


#10개 항목만 보기 앞쪽의 Rules에서 10개 미만일때
##아래와 같이 1:10을 하면 에러나옴. 본인의 상황에
# 맞추어서 개수를 작업해야함.
rules=apriori(tr,parameter=list(supp=0.1,conf=0.1)) 
inspect(rules)
inspect(rules[1:10])
inspect(sort(rules,by="lift")[1:10]) # lift(향상도) 높은순으로 10개

########################################################################
library(arulesViz)
# 가로(지지도), 세로(신뢰도), 색상(향상도) 
#아래 자료는 지지도 0.25, 신뢰도 0.5와 1일때 향상도가 높음, 진한빨강색이 표시됨.
plot(rules)


#매트릭스차트
# Ihs(가로축)-조건(x아이템)과 rhs(세로축)-결과(y아이템) 으로구성한매트릭스그래프
plot(rules,method="grouped")
# 진한 빨간색일수록 향상도가 높은 자료임.
# 동그라미가 클수록 지지도(많이 나온 빈도수가 높은 자료임)


# 각규칙별로어떤아이템들이 연관되어묶여있는지 보여주는네트워크그래프
#네트워크차트
plot(rules,method="graph")

########################################################################

# 메모리 지우기 연관분석 패키지설치
rm(list=ls())
install.packages("arules")
library(arules)
install.packages("arulesViz") 
library(arulesViz)

setwd("C:/Sources/StuddyR/day4") # 본인 상황에 맞추어서 작업
dvd<-read.csv ("dvdtrans.csv", as.is=TRUE) 
head(dvd)
dvd.list <- split(dvd$Item, dvd$ID) # id를 기준으로 item을 나눔.
dvd.list
dvd.trans <- as(dvd.list, "transactions")
dvd.trans
#지지도, 향상도 0.1 이상 자료 (0.1은 10%를 의미함 숫자값은 사용자가 임의로 넣음)
rules=apriori(dvd.trans,parameter=list(supp=0.05,conf=0.05)) 
inspect(rules)
inspect(rules[1:10])
inspect(sort(rules,by="lift")[1:10]) # lift(향상도) 높은순으로 10개
# 가로(지지도), 세로(신뢰도), 색상(향상도) 
#아래 자료는 지지도 0.25, 신뢰도 0.5와 1일때 향상도가 높음, 진한빨강색이 표시됨.
plot(rules) 
#매트릭스차트
# Ihs(가로축)-조건(x아이템)과 rhs(세로축)-결과(y아이템) 으로구성한매트릭스그래프
plot(rules,method="grouped")
# 각규칙별로어떤아이템들이 연관되어묶여있는지 보여주는네트워크그래프
plot(rules,method="graph") #네트워크차트


#########################################################################
rm(list=ls())
install.packages("arules")
library(arules)
install.packages("arulesViz") 
library(arulesViz)
setwd("C:/Sources/StuddyR/day4")
dir()
tr<-read.transactions ("자료_빅카인즈_햇반.txt",format="basket",sep=",") 
inspect(tr)
#지지도, 향상도 0.1 이상 자료 (0.1은 10%를 의미함 숫자값은 사용자가 임의로 넣음)
rules=apriori(tr,parameter=list(supp=0.05,conf=0.05)) 
inspect(rules)
inspect(rules[1:10])
inspect(sort(rules,by="lift")[1:10]) # lift(향상도) 높은순으로 10개
# 가로(지지도), 세로(신뢰도), 색상(향상도) 
#아래 자료는 지지도 0.25, 신뢰도 0.5와 1일때 향상도가 높음, 진한빨강색이 표시됨.
plot(rules) 
#매트릭스차트
# Ihs(가로축)-조건(x아이템)과 rhs(세로축)-결과(y아이템) 으로구성한매트릭스그래프
plot(rules,method="grouped")
# 각규칙별로어떤아이템들이 연관되어묶여있는지 보여주는네트워크그래프
plot(rules,method="graph") #네트워크차트