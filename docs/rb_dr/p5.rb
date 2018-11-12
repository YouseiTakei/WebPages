#**************************************************************************
#**************************************************************************
#***************************p5.rb**********ver.1.3*************************
#******************************************2018/11/11**********************
#**************************************************************************
#**************************************************************************
#system_setting------------------------------------------------------------
#require 'C:\Users\yousei takei\rb_dr\p5.rb'
#
#window_setting------------------------------------------------------------
$width = 0; $height = 0
$depth, $color_type = 8, 2
$window  = []
$grywin  = []
$binwin  = []
#render_setting------------------------------------------------------------
$noFill  = 0
$color    = [0,255,0]
$noStroke = 0
$stroke  = [0,255,0]
$strokeWeight  = 1
$alpha    = 1.0
#making_window-------------------------------------------------------------

def size(newWidth, newHeight)
  $width = newWidth;$height = newHeight;$window=[]
  $height.times do |h|
    row = []
    $width.times do |w| row.push([0,0,0]) end
    $window.push(row)
  end
end

def background(r=0,g=0,b=0,alpha=1.0)
  $color=[r,g,b];$alpha = alpha
  $height.times do |j|
$width.times do |i| point(i,j) end
  end
  $color=[255-r,255-g,255-b]
end

#render_setting------------------------------------------------------------

def fill  (r=0,g=r,b=r,alpha=1.0) $noFill = 0;$color=[r,g,b] ;$alpha=alpha  end
def stroke(r=0,g=r,b=r,alpha=1.0) $noStroke=0;$stroke=[r,g,b];$alpha=alpha  end
def strokeWeight (int, alpha=1.0) $strokeWeight  =  int      ;$alpha=alpha  end
def synth (a,b) return ( a.to_f*$alpha + b.to_f*(1.0-$alpha) ).to_i         end
def synths(a,b) return [synth(a[0],b[0]),synth(a[1],b[1]),synth(a[2],b[2])] end
def alpha(int=1.0)     $alpha    = int  end
def noFill()           $noFill   = 1    end
def noStroke()         $noStroke = 1    end
def noAlpha()          $alpha    = 1    end 
def color(r=0,g=r,b=r) return [r,g,b]   end
def red(color)         return color[0]  end
def green(color)       return color[1]  end
def blue(color)        return color[2]  end
def show()             return $window   end

#render_basic---------------------------------------------------------------
def oprod(a, b, c, d)  return a*d - b*c end
def isinside(x, y, ax, ay)
  (ax.length-1).times do |i|
    if oprod(ax[i+1]-ax[i],ay[i+1]-ay[i],x-ax[i],y-ay[i])<0 then return false end
  end
  return true
end

def convex(ax, ay)
  xmax = ax.max.to_i; xmin = ax.min.to_i
  ymax = ay.max.to_i; ymin = ay.min.to_i
  ymin.step(ymax) do |j|
    xmin.step(xmax) do |i|
    if isinside(i, j, ax, ay) then set(i, j) end
    end
  end
end
#render--------------------------------------------------------------------

#point_and_line
def point(x=0,y=0) $window[y][x] = synths($color,$window[y][x]) end
def set  (x=0,y=0) $window[y][x] = synths($stroke,$window[y][x])end
def line (x1=0,y1=0,x2=0,y2=0)
  dx = y2-y1; dy = x1-x2; n = 0.5*$stroke / Math.sqrt(dx**2 + dy**2)
  dx = dx * n; dy = dy * n
  convex([x1-dx, x1+dx, x2+dx, x2-dx, x1-dx],[y1-dy, y1+dy, y2+dy, y2-dy, y1-dy])
end

#triangle
def fill_triangle(x1=0,y1=0,x2=0,y2=0,x3=0,y3=0)
  convex([x1, x2, x3, x1], [y1, y2, y3, y1])
  convex([x1, x3, x2, x1], [y1, y3, y2, y1])
end
def noFill_triangle(x1=0,y1=0,x2=0,y2=0,x3=0,y3=0)
  line(x1,y1,x2,y2);line(x2,y2,x3,y3);line(x1,y1,x3,y3)
end
def triangle(x1=0,y1=0,x2=0,y2=0,x3=0,y3=0)
  if $noFill==1 then noFill_triangle(x1,y1,x2,y2,x3,y3) end
  if $noFill==0 then  fill_triangle(x1,y1,x2,y2,x3,y3) end
end

#rect
def fill_rect(x1=0,y1=0,x2=0,y2=0)
  y1.step(y2) do |j|
    x1.step(x2) do |i| point(i,j) end
  end
end
def noFill_rect(x1=0,y1=0,x2=0,y2=0)
  line(x1,y1,x2,y1);line(x2,y1,x2,y2)
  line(x1,y1,x1,y2);line(x1,y2,x2,y2)
end
def rect(x1=0,y1=0,x2=0,y2=0)
  if $noFill==1 then noFill_rect(x1,y1,x2,y2) end
  if $noFill==0 then  fill_rect(x1,y1,x2,y2) end
end

#ellipse
def fill_ellipse(x,y,w,h)
  i0, j0 =  (x-w).to_i, (y-w).to_i ; i1, j1 =  (x+w).to_i, (y+h).to_i
  j0.step(j1) do |j|
    i0.step(i1) do |i|
      if (i-x).to_f**2/w**2 + (j-y).to_f**2/h**2 < 1.0 then point(i, j) end
    end
  end
end
def noFill_ellipse(x=0,y=0,w,h)end
def ellipse(x=0,y=0,w,h)
  if $noFill==1 then noFill_ellipse(x,y,w,h) end
  if $noFill==0 then  fill_ellipse(x,y,w,h) end
end

#Image---------------------------------------------------------------------
#def resize(image) end
require 'csv'
def read(imager,imageg,imageb,ret=0) 
  imr=CSV.read(imager);img=CSV.read(imageg);imb=CSV.read(imageb)
  h,w=shape(imgr); list=[]
  h.times do |j|
    row=[]
    w.times do |i|
	  row.push([imr[j][i].to_i,img[j][i].to_i,imb[j][i].to_i])
	end
	list.push(row)
  end
  if ret==0 then return list end
end
#read("rb_dr/data/kn_smallr.csv","rb_dr/data/kn_smallg.csv","rb_dr/data/kn_smallb.csv")
def image(imager,imageg,imageb,ret=1)
  imr=CSV.read(imager);img=CSV.read(imageg);imb=CSV.read(imageb)
  h,ws=hape(imr); size(shape[1],shape[0])
  h.times do |j|
    w.times do |i|
	  $window[j][i] = [imr[j][i].to_i,img[j][i].to_i,imb[j][i].to_i]
	end
  end
  if ret==0 then return list end
end
#image("rb_dr/data/kn_s_r.csv","rb_dr/data/kn_s_g.csv","rb_dr/data/kn_s_b.csv")
require "zlib"
def save(naem)
  def chunk(type,data)[data.bytesize,type,data,Zlib.crc32(type+data)].pack("NA4A*N")end
  print "\x89PNG\r\n\x1a\n"
  print chunk("IHDR", [$width, $height, $depth, $color_type, 0, 0, 0].pack("NNCCCCC"))
  #image_data
  img_data = $window.map {|line| ([0] + line.flatten).pack("C*") }.join
  print chunk("IDAT", Zlib::Deflate.deflate(img_data))
  #end
  print chunk("IEND", "")
end
#numrb as nr--------------------------------------------------------------
def shape (a)   return a.length, a[0].length, a[0][0].length           end
def mean  (a)   return a.sum / a.length                                end
#gray_processing_basic----------------------------------------------------
def side_kernel(image,x,y,level)
  side=[];x0,y0=x-level,y-level
  (level*2+1).times do |j|
    sideRow=[]
    (level*2+1).times do |i| sideRow.push(image[y0+j][x0+i]) end
    side.push(sideRow)
  end
  return side
end

def grywin()
  $grywin = []
  $height,times do |j|
    row = []
    $width.times do |i|
      row.push(mean($window[j][i]))
    end
    $grywin.push(row)
  end
end

def binwin()
  graywin(); $binwin = []
  $height.times do |h|
    row = []
    $width.times do |w| row.push(($grywin[j][i]/100).to_i) end
    $binwin.push(row)
  end
end
#def edge(image) end
def gry_sum(a)
  h,w = shape(a); sum = 0
  h.times do |j| 
    w.times do |i| sum = sum + a[j][i] end
  end
  return sum
end
def gry_mean(a)
  h,w=ashape(a); hw=h*w; sum=graykernelSum(a)
  return (sum/hw).to_i
end
def gry_cal(a,b)
  c = []; h,w=shape(a)
  h.times do |j| 
    crow=[]
    w.times do |i| crow.push(a[j][i]*b[j][i]) end
    c.push(crow)
  end
  return c
end
def gry_making_kernel(level)
  kernel=[]; hw=(level*2+1)*(level*2+1)
  (level*2+1).times do |j|
    row=[]
    (level*2+1).times do |i| row.push(1.0/hw) end
	kernel.push(row)
  end
  return kernel
end
def gry_kernel(kernel)
  level=(shape(kernel)-1)/2
  (h-2*level).times do |j|
    (w-level*2).times do|i|
	  c=gray_cal(side_kernel($grysin), kernel)
	  $grywin[j][i] = gray_sum(c)/gray_sum(kernel)
    end
  end
end


def smooth(level) 
  kernel=gray_making_ernel(level)
 end

#Image_processing_basic----------------------------------------------------

def colorkernelCal(a,b)
  c = []
  a.length.times do |j| 
    crow=[]
    a[j].length.times do |i| crow.push([a[j][i][0]*b[j][i][0],a[j][i][1]*b[j][i][1],a[j][i][2]*b[j][i][2]]) end
    c.push(crow) 
  end
  return c
end

def colorkernelSum(a)
  h=a.length;w=a[0].length;sum=[0,0,0]
  h.times do |j| 
    w.times do |i| sum[0],sum[1],sum[2]=sum[0]+a[j][i][0],sum[0]+a[j][i][1],sum[0]+a[j][i][2] end
  end
  return sum
end

def colorkernelMean(a) hw=a.length*a[0].length;sum=colorkernelSum(a);return [sum[0]/hw,sum[1]/hw,sum[2]/hw] end


def allSide(level, proc)
  ($height-2*level).times do |j|
    ($width-2*level).times do |i|
        side = side()
        side.each do |l|
          side each do |j|
            #processing
        end
      end
    end
  end
end

#interaction---------------------------------------------------------------
#def keyPressed()  end
#def keyReleased() end
#def keytyped() end
#def mousePressed()  end
#def mouseReleased() end
#def mouseClicked() end
#def mouseMoved() end

#system test===============================================================
def testMat(bool=1)
  $window.each do |row|
    s = ''
    row.each do |i|
      j = (i[0]+i[1]+i[2])/3
      if bool  == 0
        if 256 > j && j >=100 then s = s + ''  + j.to_s end
        if 100 > j && j >= 10 then s = s + ' '  + j.to_s end
        if  10 > j && j >=  0 then s = s + '  ' +j.to_s end
        if 256 <=j && j <  0 then s = s + 'err' end
      end
      if bool  == 1 then s = s + '  ' + (9*j/255).to_i.to_s end
      if bool  == 2 then s = s + (9*i[0]/255).to_i.to_s+(9*i[1]/255).to_i.to_s+(9*i[2]/255).to_i.to_s end
      if bool  == 3
	    ij=(10*j/255).to_i
		#kard=[ "¡","Ÿ", "š", "™Â" , "„G", "¦", "‡]","","ž" , "ˆ"]
		s=s+kard[ij]
      end
	  if bool == 4
	    ij=(5*j/255).to_i
		#kard=["¡","š", "¦",""," "]
		s=s+kard[ij]
	  end
    end
    puts s
  end
end
def checkStatus()
  puts "noFill?:#{$noFill}"
  puts "color?:#{$color}"
  puts "noStroke?:#{$noStroke}"
  puts "stroke?:#{$stroke}"
  puts "strokeWeight?:#{$strokeWeight}"
  puts "alpha?:#{$alpha}"
end
#==========================================================================