function get_lag(result)
	hours = tonumber(results[1].text)*10 + tonumber(results[2].text)
	minutes = tonumber(results[3].text)*10 + tonumber(results[4].text) + 0.5
	microseconds = (hours*60+minutes)*60*1000
	sysLog('need to wait '..hours..' hours and '..minutes..' minutes('..microseconds..' microseconds)')
	return microseconds
end
	--[[
local dict = createOcrDict("dict.txt") 
results = ocrText(dict, 1735,952,1818,985, {"0x37332e-0x505050"}, 95, 1, 1) -- 表示范围内横向搜索，以table形式返回识别到的所有结果及其坐标
--]]






function xu_che()
	x, y = findMultiColorInRegionFuzzy(0x8f5ea0,"-45|-4|0xbdb5a4,-38|45|0xf8f3e0,59|17|0x603d3a", 90, 434,1413, 438, 1417)
	if x ~= -1 and y ~= -1 then        --忽略背景色白色的情况下找到符合条件的图片则点击
		tap(622, 1408)
		sleepRandomLag(3000)										--进入阴阳寮
		tap(1549, 1220)
		sleepRandomLag(3000)									
		tap(1050, 700)			                     --点开结界
		sleepRandomLag(3000)	
		
		accept_quest()
		x, y = findColorInRegionFuzzy(0x272420, 95, 1798, 874, 1802, 876)	 --寄养的黑色+号
		if x > -1 then
			tap(1800, 875)														--点击寄存
			sleepRandomLag(2000)	
			tap(777,712)															--点击好友
			sleepRandomLag(3000)	
			tap(1052,353)													--点击寄存
			sleepRandomLag(3000)
			tap(110, 1420)  												--点开全部式神
			sleepRandomLag(500)
			tap(351, 1180) 												-- 选择sr
			sleepRandomLag(1000)
			swip(1482, 1348, 1800, 600)  			--拖动桃花妖进入寄存
			sleepRandomLag(1000)
			tap(1200, 1030)												-- 点击确认
			sleepRandomLag(1000)
			tap(70, 70)														-- 退出界面
			sleepRandomLag(1000)
			tap(70, 70)
			sleepRandomLag(3000)
			tap(1846, 308)
			toast('开始等待6小时')
			mSleep(6*3600*1000)
			xu_che()
		else
			accept_quest()
			results = ocrText(dict, 1735,952,1818,985, {"0x37332e-0x505050"}, 95, 1, 1)
			waiting_time = get_lag(results)
			tap(70, 70)
			sleepRandomLag(1000)
			tap(70, 70)
			sleepRandomLag(3000)
			tap(1846, 308)
			mSleep(waiting_time)
			xu_che()
		end
	else                               --如果没找到符合条件的
		dialog("请进入主界面 ╮（╯▽╰）╭",0);
	end
end


function enter_jiyang()
  enter_main_function()
	sub_function:case('guild')
	tap(1549, 1220)
	mSleep(3000)									
	tap(1050, 700)			                     --点开结界
	mSleep(3000)	
end


function if_jiyang()
	accept_quest()
	local x, y = findColorInRegionFuzzy(0x272420, 95, 1798, 874, 1802, 876)	 --寄养的黑色+号
	if x > -1 then
		tap(1800, 875)														--点击寄存
		mSleep(3000)
		my_swip_2(1008, 1354, 1008, 1306, 40, 50, 5)
		mSleep(1000)
		return true
	else
		return false
	end
end


function jiyang_nextpage(times)
	if times == 0 then
		do return end
	end
	my_toast(id, '此次翻动'..times..'页')
	for i = 1, times, 1 do
	my_swip_2(1008, 1354, 1008, 610, 40, 50, 15)
	local x, y = findMultiColorInRegionFuzzy(0xcbb59c,"12|0|0xcbb59c,24|0|0xcbb59c,35|2|0xcbb59c,48|2|0xcbb59c,-21|-12|0xcbb59c,18|-12|0xcbb59c,43|-19|0xcbb59c,63|-24|0xcbb59c,79|-22|0xcbb59c", 95, 595, 1223, 690, 1318)
	--local x, y = findMultiColorInRegionFuzzy(0x716f6d,"0|2|0xe4e4e4,0|5|0x5a5a5a,0|8|0x454545,0|12|0x29221a,-2|43|0x464646,0|49|0x7f7f7f,0|51|0xd7d7d7", 90, 568, 1185, 698, 1344)
	if x > -1 then
		sysLog('底部')
	return i
	end
	mSleep(1000)
	end
	return true
end


function found_card()
	sysLog('找到斗鱼或者太鼓')
	my_toast(id, '找到斗鱼或者太鼓')
	mSleep(2000)
	tap(1048, 336)
	mSleep(2000)
	tap(100, 1427)
	mSleep(500)
	if ss_type == '0' then
		tap(73, 1077)
	elseif ss_type == '1' then
		tap(222, 1100)
	elseif ss_type == '2' then
		tap(346, 1182)
	elseif ss_type == '3' then
		tap(423, 1309)
	else
		tap(440, 1455)
	end
	mSleep(500)
	return ss_jiyang()
end


function check_one_friend()
	local if_has_card_x, if_has_card_y = myFindColor(不动风车)
	local if_jiyang_x, if_jiyang_y = myFindColor(寄养)
	if if_jiyang_x == -1 then 
		my_toast(id, '好友已经没有车可以上了, 请过一会再尝试')
		return true
	end
	while if_has_card_x == -1 do
	mSleep(1000)
	if_has_card_x, if_has_card_y = myFindColor(不动风车)
	end
	tap(1868, 727)
	if_has_card_x, if_has_card_y = myFindColor(不动风车)
	while if_has_card_x > -1 do
	mSleep(1000)
	tap(1868, 727)
	end
	mSleep(1000)
	keepScreen(true)
	local douyu_x, douyu_y = myFindColor(斗鱼)
	local taigu_x, taigu_y = myFindColor(太鼓)
	keepScreen(false)
	tap(1890, 306)
	if card_type == '0' then
		if douyu_x > -1 then
			return found_card()
		else
			my_toast(id, '没找到车')
			mSleep(2000)
			tap(67, 71)
		end
	elseif card_type == '1' then
		if taigu_x>-1 then
			return found_card()
		else
			my_toast(id, '没找到车')
			mSleep(2000)
			tap(67, 71)
		end
	else
		if taigu_x> - 1 or douyu_x > -1 then
			return found_card()
		else
			my_toast(id, '没找到车')
			mSleep(2000)
			tap(67, 71)
		end
	end
	mSleep(3000)
	tap(1043, 750) -- 式神育成中间
	mSleep(3000)
	tap(1800, 875)
	mSleep(3000)
	return false
end


function ss_jiyang()
  sysLog('ss_jiyang')
  keepScreen(true)
  for i = 1, 7, 1 do
    accept_quest()
    local emty_x, emty_y = findMultiColorInRegionFuzzy(0xf7dfa3,"-1|-1|0xc4a578,-2|-2|0xddb687,-2|3|0xd1ab7e,-2|0|0xa07e59,-1|0|0xd3b684,-5|-5|0xae8c65,-4|6|0xb08a63,-6|-7|0xa68763,-8|-8|0xad8c65",80,ssjiejie_position[i][1], ssjiejie_position[i][2], ssjiejie_position[i][3], ssjiejie_position[i][4]);
    local full_x, full_y = findMultiColorInRegionFuzzy(0xffca0d,"-8|1|0xfdcc0b,8|-1|0xfbc30e", 95, ssjiejie_position[i][1], ssjiejie_position[i][2], ssjiejie_position[i][3], ssjiejie_position[i][4])  --满字
    if emty_x > -1  and full_x == -1 then
			sysLog('找到gl'..emty_x..'.'..emty_y)
			local new_x = emty_x+100
			local new_y = emty_y+100
			sysLog('new_x '..new_x..';new_y '..new_y)
			local new = pos:new(new_x, new_y)
			local move = {x=1803, y=556}
			local step = 28
			local sleep1,sleep2 = 500,20
			new:touchMoveTo(move,step,sleep1,sleep2)
			--swip(new_x, new_y, ss_position[slot_num][1], ss_position[slot_num][2])
			mSleep(2000)
			--tap(59, 56)
			--mSleep(2000)
			keepScreen(false)
			local x, y = findMultiColorInRegionFuzzy(0xf3b25e,"-321|-4|0xdf6851,-1|57|0xf3b25e,-316|53|0xdf6851", 95, 1089, 979, 1276, 1067)
			while x == -1 do
				mSleep(200)
				x, y = findMultiColorInRegionFuzzy(0xf3b25e,"-321|-4|0xdf6851,-1|57|0xf3b25e,-316|53|0xdf6851", 95, 1089, 979, 1276, 1067)
			end
			tap(x, y)
			return true
    else
      sysLog(i..'号位未找到')
    end
  end
  keepScreen(false)
  my_swip_2(1822, 1378, 185, 1378, 50, 40, 15)
  return ss_jiyang()
end


function jiyang_once()
	enter_jiyang()
	if if_jiyang() then
		my_toast(id, '检测好友页数')
		local friend_page = jiyang_nextpage(100)
		my_toast(id, '可用好友页数为'..friend_page)
		sysLog(friend_page)
		tap(1800, 880)
		mSleep(3000)
		my_toast(id, '开始找车')
		if_jiyang()
		for pages = 0, friend_page, 1 do
			for single_friend = 1, 10 ,1 do
				my_toast(id, '找第'..pages..'页第'..single_friend..'个好友的车')
				my_swip_2(1008, 1354, 1008, 1306, 40, 50, 5)
				mSleep(1000)
				jiyang_nextpage(pages)
				tap(jiejie_friend[single_friend][1], jiejie_friend[single_friend][2])
				mSleep(3000)
				if check_one_friend() then
					do return end
				end
			end
		end
	else
		my_toast(id, '不能寄养')
	end
end


function main_xuche(xuche_ret, xuche_results)
  if xuche_ret==0 then	
    toast("您选择了取消，停止脚本运行")
    lua_exit()
  end
  card_type = tonumber(xuche_results['10'])
  ss_type = tonumber(xuche_results['100'])
	return jiyang_once()
end

--ss_jiyang('2')
--[[
for k,v in pairs(results) do
  sysLog(string.format('{x=%d, y=%d, text=%s}', v.x, v.y, v.text))
end
--]]