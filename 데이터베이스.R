# data.table 패키지가 있는지 확인하고 없으면 설치합니다.
if (!requireNamespace("data.table")) install.packages("data.table")
# data.table 패키지를 사용할 수 있게 불러옵니다.
library(data.table)
# tran.csv 파일이 data/recomen 폴더에 있는지 확인 합니다.
chk<-dir("./data/recomen", pattern = "tran.csv")
# 없으면 다운로드합니다.
if(identical(chk,character(0))){
  recoment<-"http://rcoholic.duckdns.org/oc/index.php/s/jISrPutj4ocLci2/download"
  download.file(recoment,destfile="./data/recomen/tran.csv",mode='wb')
}
# fread 함수를 이용해서 csv 파일을 R객체로 불러옵니다.
chennel<-fread("./data/recomen/chennel.csv")
competitor<-fread("./data/recomen/competitor.csv")
customer<-fread("./data/recomen/customer.csv")
item<-fread("./data/recomen/item.csv")
membership<-fread("./data/recomen/membership.csv")
tran<-fread("./data/recomen/tran.csv")

print(head(iris))

if (!require(devtools)) install.packages("devtools")
if (!require(DBI)) devtools::install_github("rstats-db/DBI")
if (!require(RSQLite)) devtools::install_github("rstarts-db/RSQLite")

library(DBI)
library(RSQLite)
library(data.table)

# SQLite와 연결
# conn은 관례적으로 연결 정보를 저장하는 객체의 이름이며 SQLite는 DB가 파일로 구성되어
# 있어서 권한설정(ID,Password)이 없고 연결 정보도 단순(host 없음)함

conn <- dbConnect(RSQLite::SQLite(), dbname = "C:/Users/Kim Chang Yong/Desktop/R/project_3/class2.sqlite")
conn

# DB내에 있는 테이블의 이름을 확인함
dbListTables(conn)

# DBI 명령으로 table 만들기
dbWriteTable(conn, "mtcars", mtcars, overwrite = T)
dbListTables(conn)
# DBI 명령으로 table 불러오기
dbReadTable(conn, "mtcars")
# DBI 명령으로 table 지우기
dbRemoveTable(conn, "mtcars")
dbListTables(conn)

#실습
conn <- dbConnect(RSQLite::SQLite(), dbname = "C:/Users/Kim Chang Yong/Desktop/R/project_3/db_KCY.sqplite" )
dbListTables(conn)
chen <- read.csv("C:/Users/Kim Chang Yong/Desktop/R/project_3/netflix_titles_nov_2019_pretreatment.csv")
dbWriteTable(conn, "dbchen", chen, overwrite = T)
dbReadTable(conn, "dbchen")
identical(dbReadTable(conn,"dbchen"), chen)
#왜 FALSE 가 나올까요 분명 같은 데이터를 불러왔는데 말이죠...
