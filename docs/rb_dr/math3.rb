# coding: cp932
#����: n:��f���ł���e�X�g�Ώۂ̐���
#�o��: 1:�f���̏ꍇ, 0:�������̏ꍇ

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



