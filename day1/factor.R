# 파이썬에서는 직업명 = ['',''] / 파이썬에서는 초기화 => 직업명 =[]
# R에서는 직업명=c('','') / R에서는 리스트 초기화는 => 직업명 = c()

직업명 = c('데이터과학자','엔지니어','엔지니어','세금관리자','분석관리자')
채용수 = c(4.184,2.725,2.599,3.317,1.958)
평균급여 = c(110,110,106,110,112)
직업만족도 = c(4.4,4.0,4.3,4.0,4.1)
str(직업명)
summary(직업명)
summary(채용수)
summary(평균급여)
summary(직업만족도)
# summary(숫자형
plot(평균급여)  # 산점도
fa=as.factor(직업명)
fa
# [1] 데이터과학자 엔지니어     엔지니어     세금관리자   분석관리자  
# Levels: 데이터과학자 분석관리자 세금관리자 엔지니어
# Levels => 문자열의 중복제거 유니크한 값, 펙터에만 나옴
직업명

summary(fa)
# > summary(fa)
# 데이터과학자   분석관리자   세금관리자     엔지니어 
           1            1            1            2 

plot(fa)

data=data.frame(직업명,채용수,평균급여,직업만족도)
data
#        직업명 채용수 평균급여 직업만족도
# 1 데이터과학자  4.184      110        4.4
# 2     엔지니어  2.725      110        4.0
# 3     엔지니어  2.599      106        4.3
# 4   세금관리자  3.317      110        4.0
# 5   분석관리자  1.958      112        4.1
str(data)
#'data.frame':   5 obs. of  4 variables:
# $ 직업명    : chr  "데이터과학자" "엔지니어" "엔지니어" "세금관리자" ...
# $ 채용수    : num  4.18 2.73 2.6 3.32 1.96
# $ 평균급여  : num  110 110 106 110 112
# $ 직업만족도: num  4.4 4 4.3 4 4.1
plot(data)

data$직업명	# data안에 들어가는 직업명
# [1] "데이터과학자" "엔지니어"     "엔지니어"     "세금관리자"   "분석관리자"  




# strsplit(변수, 글자를 나눌 기준)


a='python/r/cobol/r'
strsplit(a,"/")
# [1] "python" "r"      "cobol"  "r" 
plot(a) # 에러


a='python/r/cobol/r'
tmp = strsplit(a,"/")
tmp
tmp[[1]][2]

a=c('파이썬, 데이터분석가,인공지능','R,데이터분석가,빅데이터')
tmp = strsplit(a,",")
tmp[[2]]


a=c('파이썬, 데이터분석가,인공지능','R,데이터분석가,빅데이터')
tmp = strsplit(a,",")
tmp
summary(tmp)
summary(unlist(tmp))			# 데이터 다 풀기




a=c('파이썬, 데이터분석가,인공지능','R,데이터분석가,빅데이터')
tmp = strsplit(a,",")
tmp
summary(tmp)
tmp1=unlist(tmp)
tmp2=as.factor(tmp1)
summary(tmp2)
plot(tmp2)


# factor로 만든 자료는 summary, plot은 되지만, split 안됨
a=c('파이썬-20, 데이터분석가-20,인공지능','R,데이터분석가,빅데이터')
tmp = strsplit(a,",")
tmp
summary(tmp)
tmp1=unlist(tmp)
tmp1
tmp2=as.factor(tmp1)
summary(tmp2)
plot(tmp2)
strsplit(tmp2,'-') # factor는 strsplit안됨
strsplit(as.character(tmp),'-')	 # character로 바꿔서 strsplit 해야함



# factor형은 strsplit안됨
b=as.factor(a)
strsplit(b,"/")	# 에러
plot(b)


# test

