# ojdbc.jar를 이용하여 데이터 접속을 위한 라이브러리

## - 사전 설치 사항
## - jdk 설치 및 환경변수 등록하기

install.packages("RJDBC")
library(RJDBC)

# 오라클 드라이버 연결 경로 설정
driver <- JDBC("oracle.jdbc.OracleDriver",
              classPath = "C:/DV/Server/Oracle/product/12.2.0/dbhome_1/inventory/Scripts/ext/jlib/ojdbc8.jar")
driver


# 오라클 접속하기
conn <- dbConnect(driver,
                  "jdbc:oracle:thin:@//localhost:1521/orcl",
                  "busan","dbdb")
conn


###### 데이터 [입력/수정/삭제] 하기
###### - dbSendQuery()함수는 동일하게 사용
###### - dbSendQuery()에서 입력 시에는 [한건만 입려] 가능

sql_in <- paste(" Insert into test ",
                " (AA,BB,CC) ",
                " values('a1','b1','c1') ")
sql_in


in_stat = dbSendQuery(conn, sql_in)
in_stat


dbClearResult(in_stat)


## 데이터 조건 [조회]하기
sql_sel <- " Select * From test Where AA = 'a1'"
sql_sel


getData <- dbGetQuery(conn, sql_sel)
getData

getData$AA
str(getData)


######  **중요**무조건 오라클 접속 해제하기
dbDisconnect(conn)

