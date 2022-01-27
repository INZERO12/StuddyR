## 교제 62p
install.packages('cowsay')
library(cowsay)		# R이 있는 위치로 불러오는것

say('heoo',by='cat')		# 'heoo'란 글과 고양이그림
say('heoo',by='snowman')	# # 'heoo'란 글과 눈사람그림

?say				# say에 관한 도움말

say('heoo',by='cow')
say('heoo',by='ant')
say('heoo',by='cow')

byNameList=c('cat','ghost','ant')		# cat,ghost,ant 한번에 출력

### for 사용1
for (byName in byNameList){
	say('Hello',by=byName)
}


### for 사용2
for (index in 1:length(byNameList)){
	say('Hello',by=byNameList[index])
}