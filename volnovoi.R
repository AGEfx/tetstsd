m <- matrix(c(0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,-1,0,0,-1,0,
              0,0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,-1,0,0,0,-1,
              0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,0,-1,-1,0,0,0,
              -1,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,-1,0,0,0,-1,0,0,0,0,0,0,0,-1,0,
              0,0,-1,-1,0,0,-1,0,0,0,0,0,0,-1,0,0,0,-1,0,0,
              0,0,0,0,-1,0,0,0,-1,0,0,0,0,0,0,-1,0,-1,-1,-1,
              -1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), nrow = 10, ncol = 20, byrow = TRUE)



start <- c(10,1) #����� ����
finish <- c(9,20) #���������� ����

m[start[1],start[2]] <- 1
d <- 2 #����� �����

wave <- TRUE #����� ���������� �� ����������� ��������������� �����

while(wave == TRUE && m[finish[1],finish[2]]==0) {
  wave <- FALSE
  for (i in 1:nrow(m)) {
    for (j in 1:ncol(m)) {
      if (m[i, j] == d - 1) {
        if(i + 1 <= nrow(m) && m[i+1,j] == 0){
          m[i+1,j] <- d
          wave <- TRUE
        }
        if(i - 1 > 0 && m[i-1,j] == 0){
          m[i-1,j] <- d
          wave <- TRUE
        }
        if(j-1 > 0 && m[i,j-1] == 0){
          m[i,j-1] <- d
          wave <- TRUE
        }
        if(j + 1 <= ncol(m) && m[i,j+1] == 0){
          m[i,j+1] <- d
          wave <- TRUE
        }
      }
    }
  }
  
  d <- d + 1
}

m #����� ���������������� �������


if(m[finish[1],finish[2]]>0){
  path <- c()
  d <- d - 1 #�.� ��� �������� �� ������ ��� � ����� �� ��������� ���� ���������
  
  x <- finish[1]
  y <- finish[2]
  while(m[x,y] != 1){
    if(x + 1 <= nrow(m) && m[x+1,y] == d - 1){
      path <- append(path,(paste(x,y)))
      x <- x + 1
      d <- d - 1 
      next
    }
    if(x - 1 > 0 && m[x-1,y] == d - 1){
      path <- append(path,(paste(x,y)))
      x <- x - 1
      d <- d - 1 
      next
    }
    if(y-1 > 0 && m[x,y-1] == d - 1){
      path <- append(path,(paste(x,y)))
      y <- y - 1
      d <- d - 1 
      next
    }
    if(y + 1 <= ncol(m) && m[x,y+1] == d - 1){
      path <- append(path,(paste(x,y)))
      y <- y + 1
      d <- d - 1 
      next
    }
  }


colors <- c()
for(i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    if (m[i, j] == -1) { #�����
      colors <- append(colors, "black")
    }else if(m[i, j] == 1){ #��������� �������
      colors <- append(colors,"blue")
    }else if(i == finish[1] && j == finish[2]){ #��������
      colors <- append(colors,"purple")
    } else if(paste(i,j) %in% path){
      colors <- append(colors, "red") #����
    }
    else{
      colors <- append(colors, "green") #������
    }
  }
}

c(sapply(seq(-1, -1*nrow(m)), function(i) rep(i, ncol(m))))

plot(c(rep(seq(1,ncol(m)),nrow(m))),
     c(sapply(seq(-1, -1*nrow(m)), function(i) rep(i, ncol(m)))),
     pch=15,
     col=colors,
     xlab="",ylab="")
axis(1, at = 1:ncol(m))
axis(2, at = -nrow(m):-1)
}else{
  print("���� ���")
}