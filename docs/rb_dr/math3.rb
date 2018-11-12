# coding: cp932
#入力: n:奇素数であるテスト対象の整数
#出力: 1:素数の場合, 0:合成数の場合

def LLehmer(n)
  s = 4;m=(1<<n)-1
  for i in 2..n-1 do s = (s.Math.sqrt-2)%m end
  if s==0 then return 1 else return 0 end
end

def LLehmerFast(n)
  s=4;m=(1<<p)-1
  for i in 2..p-1 do
    sq=s*s
    s=sq&m+(sq>>p)
    if s>=m then s=s-m end
    s=s-2
  end
  if s==0 then return 1 else return 0 end
end

def AKS(p)

end



