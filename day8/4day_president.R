###### 대통령 4명의 연설문 워드클라우드 키워드 빈도 분석
# 박근혜 대통령
president_park <- readLines("./Data/president_park.txt",encoding = "UTF-8")
head(president_park)

## 특수문자 제거
# install.packages("stringr")
library(stringr)

# 특수문자 제거
president_park <- str_replace_all(president_park,"\\W"," ")
head(president_park)

## 가장 많이 사용된 단어 알아보기
# 명사 추출하기 -> extracNoun
library(KoNLP)

# 가사에서 명사추출
nouns <- extractNoun(president_park)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
wordcount


## 자주 사용된 단어 빈도표 만들기
# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word

# 변수명 수정
library(dplyr)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word

# 두 글자 이상 단어 추출
# nchar -> 글자의갯수
df_word <- filter(df_word, nchar(word) >= 2)
df_word

top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)
top_20


## 워드 클라우드 만들기
## 패키지 준비하기
# 패키지 설치
# install.packages("wordcloud")

# 패키지 로드
library(wordcloud)

library(RColorBrewer)

## 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")  # Dark2 색상 목록에서 8개 색상

## 워드 클라우드 생성
set.seed(1234)                      # 난수고정
wordcloud(words = df_word$word,     # 단어
          freq = df_word$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록

## 단어 색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                      # 난수 고정
wordcloud(words = df_word$word,     # 단어
          freq = df_word$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록






################################################################################
## 이명박 대통령
president_lee <- readLines("./Data/president_lee.txt",encoding = "UTF-8")
head(president_lee)

## 특수문자 제거
# install.packages("stringr")
library(stringr)

# 특수문자 제거
president_lee <- str_replace_all(president_lee,"\\W"," ")
head(president_park)

## 가장 많이 사용된 단어 알아보기
# 명사 추출하기 -> extracNoun
library(KoNLP)

# 가사에서 명사추출
nouns2 <- extractNoun(president_lee)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount2 <- table(unlist(nouns2))
wordcount2


## 자주 사용된 단어 빈도표 만들기
# 데이터 프레임으로 변환
df_word2 <- as.data.frame(wordcount2, stringsAsFactors = F)
df_word2

# 변수명 수정
library(dplyr)
df_word2 <- rename(df_word2,
                  word = Var1,
                  freq = Freq)
df_word2

# 두 글자 이상 단어 추출
# nchar -> 글자의갯수
df_word2 <- filter(df_word2, nchar(word) >= 2)
df_word2

top20_2 <- df_word2 %>% 
  arrange(desc(freq)) %>% 
  head(20)
top20_2


## 워드 클라우드 만들기
## 패키지 준비하기
# 패키지 설치
# install.packages("wordcloud")

# 패키지 로드
library(wordcloud)

library(RColorBrewer)

## 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")  # Dark2 색상 목록에서 8개 색상

## 워드 클라우드 생성
set.seed(1234)                      # 난수고정
wordcloud(words = df_word2$word,     # 단어
          freq = df_word2$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록

## 단어 색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                      # 난수 고정
wordcloud(words = df_word2$word,     # 단어
          freq = df_word2$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록








################################################################################
# 노무현 대통령
president_no <- readLines("./Data/president_no.txt",encoding = "UTF-8")
head(president_no)

## 특수문자 제거
# install.packages("stringr")
library(stringr)

# 특수문자 제거
president_no <- str_replace_all(president_no,"\\W"," ")
head(president_no)

## 가장 많이 사용된 단어 알아보기
# 명사 추출하기 -> extracNoun
library(KoNLP)

# 가사에서 명사추출
nouns3 <- extractNoun(president_no)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount3 <- table(unlist(nouns3))
wordcount3


## 자주 사용된 단어 빈도표 만들기
# 데이터 프레임으로 변환
df_word3 <- as.data.frame(wordcount3, stringsAsFactors = F)
df_word3

# 변수명 수정
library(dplyr)
df_word3 <- rename(df_word3,
                  word = Var1,
                  freq = Freq)
df_word3

# 두 글자 이상 단어 추출
# nchar -> 글자의갯수
df_word3 <- filter(df_word3, nchar(word) >= 2)
df_word3

top20_3 <- df_word3 %>% 
  arrange(desc(freq)) %>% 
  head(20)
top20_3


## 워드 클라우드 만들기
## 패키지 준비하기
# 패키지 설치
# install.packages("wordcloud")

# 패키지 로드
library(wordcloud)

library(RColorBrewer)

## 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")  # Dark2 색상 목록에서 8개 색상

## 워드 클라우드 생성
set.seed(1234)                      # 난수고정
wordcloud(words = df_word3$word,     # 단어
          freq = df_word3$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록

## 단어 색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                      # 난수 고정
wordcloud(words = df_word3$word,     # 단어
          freq = df_word3$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록





################################################################################
### 김대중 대통령
president_kim <- readLines("./Data/president_kim.txt",encoding = "UTF-8")
head(president_kim)

## 특수문자 제거
# install.packages("stringr")
library(stringr)

# 특수문자 제거
president_kim <- str_replace_all(president_kim,"\\W"," ")
head(president_kim)

## 가장 많이 사용된 단어 알아보기
# 명사 추출하기 -> extracNoun
library(KoNLP)

# 가사에서 명사추출
nouns4 <- extractNoun(president_kim)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount4 <- table(unlist(nouns4))
wordcount4


## 자주 사용된 단어 빈도표 만들기
# 데이터 프레임으로 변환
df_word4 <- as.data.frame(wordcount4, stringsAsFactors = F)
df_word4

# 변수명 수정
library(dplyr)
df_word4 <- rename(df_word4,
                   word = Var1,
                   freq = Freq)
df_word4

# 두 글자 이상 단어 추출
# nchar -> 글자의갯수
df_word4 <- filter(df_word4, nchar(word) >= 2)
df_word4

top20_4 <- df_word4 %>% 
  arrange(desc(freq)) %>% 
  head(20)
top20_4


## 워드 클라우드 만들기
## 패키지 준비하기
# 패키지 설치
# install.packages("wordcloud")

# 패키지 로드
library(wordcloud)

library(RColorBrewer)

## 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")  # Dark2 색상 목록에서 8개 색상

## 워드 클라우드 생성
set.seed(1234)                      # 난수고정
wordcloud(words = df_word4$word,     # 단어
          freq = df_word4$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록

## 단어 색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                      # 난수 고정
wordcloud(words = df_word4$word,     # 단어
          freq = df_word4$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록






################################################################################
### 이승만 대통령
president_lees <- readLines("./Data/president_lees.txt",encoding = "UTF-8")
head(president_lees)

## 특수문자 제거
# install.packages("stringr")
library(stringr)

# 특수문자 제거
president_lees <- str_replace_all(president_lees,"\\W"," ")
head(president_lees)

## 가장 많이 사용된 단어 알아보기
# 명사 추출하기 -> extracNoun
library(KoNLP)

# 가사에서 명사추출
nouns5 <- extractNoun(president_lees)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount5 <- table(unlist(nouns5))
wordcount5


## 자주 사용된 단어 빈도표 만들기
# 데이터 프레임으로 변환
df_word5 <- as.data.frame(wordcount5, stringsAsFactors = F)
df_word5

# 변수명 수정
library(dplyr)
df_word5 <- rename(df_word5,
                   word = Var1,
                   freq = Freq)
df_word5

# 두 글자 이상 단어 추출
# nchar -> 글자의갯수
df_word5 <- filter(df_word5, nchar(word) >= 2)
df_word5

top20_5 <- df_word5 %>% 
  arrange(desc(freq)) %>% 
  head(20)
top20_5


## 워드 클라우드 만들기
## 패키지 준비하기
# 패키지 설치
# install.packages("wordcloud")

# 패키지 로드
library(wordcloud)

library(RColorBrewer)

## 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")  # Dark2 색상 목록에서 8개 색상

## 워드 클라우드 생성
set.seed(1234)                      # 난수고정
wordcloud(words = df_word5$word,     # 단어
          freq = df_word5$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록

## 단어 색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                      # 난수 고정
wordcloud(words = df_word5$word,     # 단어
          freq = df_word5$freq,      # 빈도
          min.freq = 2,             # 최소 단어빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.per = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록


