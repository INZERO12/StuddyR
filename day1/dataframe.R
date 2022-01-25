# 교제 166p
# 데이터프레임 만들기
city <- c('Seoul','Tokyo','Washington')
rank<-c(1,2,3)
city.info<-data.frame(city, rank)
city.info

#         city rank	# city, bank 같은 것을 '필드'라고 부른다
# 1      Seoul    1
# 2      Tokyo    2
# 3 Washington    3


# iris 데이터셋
# iris는 내장 데이터
iris[,c(1:2)] 				# 1~2열의 모든 데이터
iris[,c(1,3,5)]				# 1, 3, 5열의 모든 데이터
iris[,c("Sepal.Length","Species")]	# 1, 5열의 모든 데이터
iris[1:5,]					# 1~5행의 모든 데이터
iris[1:5,c(1:3)]				# 1~5행의 데이터 중 1, 3열의 데이터



