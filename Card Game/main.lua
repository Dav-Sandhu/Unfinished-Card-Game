local width,height = love.graphics.getDimensions()

local images = require('images')
local const = require('const')
local tables = require('tables')
local setQuads = require('setQuads')

function shuffleTable( t )
    local rand = math.random 
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

function love.load()
   if love.system.getOS() == "Android" then
	   const.control = 1
	   love.window.setFullscreen(true)
   else 
	   const.control = 2
   end
   math.randomseed(os.time())
   cardIndex = {
	[1]="knight",
	[2]="soldier",
	[3]="conqueror",
	[4]="swordsman",
	[5]="sword",
	[6]="shield",
	[7]="potion",
	[8]="rebuild"
   }
   cards = {
	knight=function()
		return{
		cardType = 1, 
		atkTroop = 1,
		atkCastle = 0,
		health = 6}
	end,
	soldier=function()
		return {
		cardType = 1, 
		atkTroop = 2,
		atkCastle = 1,
		health = 4}
	end, 
	conqueror=function()
		return{
		cardType = 1, 
		atkTroop = 1,
		atkCastle = 2,
		health = 2}	
	end, 
	swordsman=function()
		return {
		cardType = 1, 
		atkTroop = 3,
		atkCastle = 1,
		health = 3}
	end, 
	sword=function() 
		return {
		cardType = 2,
		chealthGain = 0,
		disposable = false,
		healthGain = 0,
		atkGain = 1}
		
	end, 
	shield=function()
		return {
		cardType = 2,
		chealthGain = 0,
		disposable = false,
		healthGain = 2,
		atkGain = 0}	
	end, 
	potion=function()
		return {
		cardType = 2,
		chealthGain = 0,
		disposable = true,
		healthGain = 1,
		atkGain = 0}	
	end, 
	rebuild=function()
		return {
		cardType = 2,
		chealthGain = 1,
		disposable = true,
		healthGain = 0,
		atkGain = 0}	
	end
  } 
end

function details(hand)
	for i=1,3,1 do 
		if hand[i] ~= nil then
			if const.cardSelect == i then
				love.graphics.draw(images.cardImg, tables.quads[hand[i]], (445/2)+(-90+(60*(i-1))), 160)
				if cards[cardIndex[hand[i]]]().cardType == 1 then
					love.graphics.print("Health: "..cards[cardIndex[hand[i]]]().health, 355, 100)
					love.graphics.print("Attack: "..cards[cardIndex[hand[i]]]().atkTroop, 355, 125)
					love.graphics.print("Conquer: "..cards[cardIndex[hand[i]]]().atkCastle, 355, 150)
				else
					love.graphics.print("+"..cards[cardIndex[hand[i]]]().chealthGain.." Castle HP", 355, 150)
					love.graphics.print("+"..cards[cardIndex[hand[i]]]().healthGain.." Health", 355, 125)
					love.graphics.print("+"..cards[cardIndex[hand[i]]]().atkGain.." Attack", 355, 100)
					if cards[cardIndex[hand[i]]]().disposable == true then
						love.graphics.print("Disposable", 355, 75)
					end
				end
			else
				love.graphics.draw(images.cardImg, tables.quads[hand[i]], (445/2)+(-90+(60*(i-1))), 165)
			end
		end
	end
end

function love.draw()
	love.graphics.scale(width/445,height/250)
	love.graphics.setFont(love.graphics.newFont(12))
	setQuads()
	if const.event > 2 then
		if const.event > 3 then
			love.graphics.draw(images.field, 0, 0)
		elseif const.event == 3 then
			love.graphics.draw(images.back, 0, 0)
		end
		love.graphics.draw(images.layout, 0, 0)
	end
	if const.event == 1 then
		love.graphics.setBackgroundColor(0, 0, 0)
		love.graphics.print("Boomnack Presents", (445/2)-50,250/2)
	elseif const.event == 2 then
	    love.graphics.draw(images['title' .. const.titleSelect], 0, 0)
	elseif const.event == 3 then
		love.graphics.print("Player "..const.turn.." Select "..const.cardSelect.." more cards!",(445/2)-80,12)
		love.graphics.draw(images.cardImg, tables.quads[const.curCard], (445/2)-20, 250/2-40)
	elseif const.event == 4 then
		love.graphics.print("Player "..const.turn.." turn", (445/2)-30, 12)
		if const.turn == 2 then
			love.graphics.draw(images.pcastle, 15, 20, 0, 0.17, 0.17)
			love.graphics.draw(images.ecastle, 15, 140, 0, 0.17, 0.17)
			love.graphics.draw(images.empty, 35, 80, 0, 0.5, 0.5)
			love.graphics.draw(images.empty, 35, 120, 0, 0.5, 0.5)
		else
			love.graphics.draw(images.ecastle, 15, 20, 0, 0.17, 0.17)
			love.graphics.draw(images.pcastle, 15, 140, 0, 0.17, 0.17)
			love.graphics.draw(images.empty, 35, 80, 0, 0.5, 0.5)
			love.graphics.draw(images.empty, 35, 120, 0, 0.5, 0.5)
		end
		if tables.conquerfield[1] ~= nil and const.turn == 1 then
			love.graphics.draw(images.cardImg, tables.quads[tables.conquerfield[1]], 35, 80, 0, 0.5, 0.5)
		elseif tables.conquerfield[1] ~= nil and const.turn == 2 then
			love.graphics.draw(images.cardImg, tables.quads[tables.conquerfield[1]], 35, 120, 0, 0.5, 0.5)
		end
		if tables.conquerfield[2] ~= nil and const.turn == 2 then
			love.graphics.draw(images.cardImg, tables.quads[tables.conquerfield[2]], 35, 80, 0, 0.5, 0.5)
		elseif tables.conquerfield[2] ~= nil and const.turn == 1 then
			love.graphics.draw(images.cardImg, tables.quads[tables.conquerfield[2]], 35, 120, 0, 0.5, 0.5)
		end
		if const.optionBox == true then
			love.graphics.draw(images['options' .. const.optionSel], 70, 80, 0, 0.75, 0.75)
		elseif const.optionBox2 == true then 
			love.graphics.draw(images['itemoptions' .. const.optionSel], 70, 80, 0, 0.75, 0.75)
		end
		if const.cardSelect > 3 then
			if const.cardSelect <= 6 then
				love.graphics.draw(images.imgSel, ((445/2)-50.5)+((const.cardSelect-4)*30), 119.5, 0, 0.5, 0.5)
			elseif const.cardSelect > 6 then
				love.graphics.draw(images.imgSel, ((445/2)-50.5)+((const.cardSelect-7)*30), 79.5, 0, 0.5, 0.5)
			end
		end
		if const.turn == 1 then
			details(tables.p1hand)
			love.graphics.draw(images.deck1, 35, 205, 0, 0.5, 0.5)
			love.graphics.print(table.getn(tables.p1Cards), 40, 215)
		elseif const.turn == 2 then
			details(tables.p2hand)
			love.graphics.draw(images.deck2, 35, 205, 0, 0.5, 0.5)
			love.graphics.print(table.getn(tables.p2Cards), 40, 215)
		end
		for i=1,3,1 do 
			if tables.p1field[i] == 0 then
				if const.turn == 2 then
					love.graphics.draw(images.empty, (445/2)+(-50+(30*(i-1))), 80, 0, 0.5, 0.5)
				else
					love.graphics.draw(images.empty, (445/2)+(-50+(30*(i-1))), 120, 0, 0.5, 0.5)
				end
			else
				if const.turn == 1 then
					love.graphics.draw(images.cardImg, tables.quads[tables.p1field[i]], (445/2)+(-50+(30*(i-1))), 120, 0, 0.5, 0.5)
					if const.cardSelect == i+3 then
						if cards[cardIndex[tables.p1field[i]]]().cardType == 1 then
							love.graphics.print("Health: "..cards[cardIndex[tables.p1field[i]]]().health, 355, 100)
							love.graphics.print("Attack: "..cards[cardIndex[tables.p1field[i]]]().atkTroop, 355, 125)
							love.graphics.print("Conquer: "..cards[cardIndex[tables.p1field[i]]]().atkCastle, 355, 150)
						else
							love.graphics.print("+"..cards[cardIndex[tables.p1field[i]]]().chealthGain.." Castle HP", 355, 150)
							love.graphics.print("+"..cards[cardIndex[tables.p1field[i]]]().healthGain.." Health", 355, 125)
							love.graphics.print("+"..cards[cardIndex[tables.p1field[i]]]().atkGain.." Attack", 355, 100)
							if cards[cardIndex[tables.p1field[i]]]().disposable == true then
								love.graphics.print("Disposable", 355, 75)
							end
						end
					end
				else
					love.graphics.draw(images.cardImg, tables.quads[tables.p1field[i]], (445/2)+(-50+(30*(i-1)))+(55/2), 117.5, math.pi, 0.5, 0.5)
					if const.cardSelect == i+6 then
						if cards[cardIndex[tables.p1field[i]]]().cardType == 1 then
							love.graphics.print("Health: "..cards[cardIndex[tables.p1field[i]]]().health, 355, 100)
							love.graphics.print("Attack: "..cards[cardIndex[tables.p1field[i]]]().atkTroop, 355, 125)
							love.graphics.print("Conquer: "..cards[cardIndex[tables.p1field[i]]]().atkCastle, 355, 150)
						else
							love.graphics.print("+"..cards[cardIndex[tables.p1field[i]]]().chealthGain.." Castle HP", 355, 150)
							love.graphics.print("+"..cards[cardIndex[tables.p1field[i]]]().healthGain.." Health", 355, 125)
							love.graphics.print("+"..cards[cardIndex[tables.p1field[i]]]().atkGain.." Attack", 355, 100)
							if cards[cardIndex[tables.p1field[i]]]().disposable == true then
								love.graphics.print("Disposable", 355, 75)
							end
						end
					end
				end
			end
			if tables.p2field[i] == 0 then
				if const.turn == 1 then
					love.graphics.draw(images.empty, (445/2)+(-50+(30*(i-1))), 80, 0, 0.5, 0.5)
				else
					love.graphics.draw(images.empty, (445/2)+(-50+(30*(i-1))), 120, 0, 0.5, 0.5)
				end
			else
				if const.turn == 2 then
					love.graphics.draw(images.cardImg, tables.quads[tables.p2field[i]], (445/2)+(-50+(30*(i-1))), 120, 0, 0.5, 0.5)
					if const.cardSelect == i+3 then
						if cards[cardIndex[tables.p2field[i]]]().cardType == 1 then
							love.graphics.print("Health: "..cards[cardIndex[tables.p2field[i]]]().health, 355, 100)
							love.graphics.print("Attack: "..cards[cardIndex[tables.p2field[i]]]().atkTroop, 355, 125)
							love.graphics.print("Conquer: "..cards[cardIndex[tables.p2field[i]]]().atkCastle, 355, 150)
						else
							love.graphics.print("+"..cards[cardIndex[tables.p2field[i]]]().chealthGain.." Castle HP", 355, 150)
							love.graphics.print("+"..cards[cardIndex[tables.p2field[i]]]().healthGain.." Health", 355, 125)
							love.graphics.print("+"..cards[cardIndex[tables.p2field[i]]]().atkGain.." Attack", 355, 100)
							if cards[cardIndex[tables.p2field[i]]]().disposable == true then
								love.graphics.print("Disposable", 355, 75)
							end
						end
					end
				else
					love.graphics.draw(images.cardImg, tables.quads[tables.p2field[i]], (445/2)+(-50+(30*(i-1)))+(55/2), 117.5, math.pi, 0.5, 0.5)
					if const.cardSelect == i+6 then
						if cards[cardIndex[tables.p2field[i]]]().cardType == 1 then
							love.graphics.print("Health: "..cards[cardIndex[tables.p2field[i]]]().health, 355, 100)
							love.graphics.print("Attack: "..cards[cardIndex[tables.p2field[i]]]().atkTroop, 355, 125)
							love.graphics.print("Conquer: "..cards[cardIndex[tables.p2field[i]]]().atkCastle, 355, 150)
						else
							love.graphics.print("+"..cards[cardIndex[tables.p2field[i]]]().chealthGain.." Castle HP", 355, 150)
							love.graphics.print("+"..cards[cardIndex[tables.p2field[i]]]().healthGain.." Health", 355, 125)
							love.graphics.print("+"..cards[cardIndex[tables.p2field[i]]]().atkGain.." Attack", 355, 100)
							if cards[cardIndex[tables.p2field[i]]]().disposable == true then
								love.graphics.print("Disposable", 355, 75)
							end
						end
					end
				end
			end
		end
	end
end

function mobile()
	touches = love.touch.getTouches()
	for i, id in ipairs(touches) do
		x, y = love.touch.getPosition(id)
	end
end

function pc(dt)
	const.deltaTime = const.deltaTime + dt
	if const.event == 2 then
		if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
			if const.deltaTime > 0.1 then
				if const.titleSelect == 1 then
					const.titleSelect = 4
				else
					const.titleSelect = const.titleSelect - 1
				end
				const.deltaTime = 0
			end
		elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
			if const.deltaTime > 0.1 then
				if const.titleSelect == 4 then
					const.titleSelect = 1
				else
					const.titleSelect = const.titleSelect + 1
				end
				const.deltaTime = 0
			end
		elseif love.keyboard.isDown("return") then
			if const.deltaTime > 0.1 then
				if const.titleSelect == 3 then
					const.event = 3
				end
				const.deltaTime = 0
			end
		end
	elseif const.event == 3 then
		if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
			if const.deltaTime > 0.25 then
				if const.curCard == 1 then
					const.curCard = 8
				else
					const.curCard = const.curCard - 1
				end
				const.deltaTime = 0
			end
		elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
			if const.deltaTime > 0.25 then
				if const.curCard == 8 then
					const.curCard = 1
				else
					const.curCard = const.curCard + 1
				end
				const.deltaTime = 0
			end
		elseif love.keyboard.isDown("return") then
			if const.deltaTime > 0.1 then
				if const.curCard > 0 then
					if const.turn == 1 then
						tables.p1Cards[const.cardSelect] = const.curCard
					elseif const.turn == 2 then
						tables.p2Cards[const.cardSelect] = const.curCard
					end
					const.cardSelect = const.cardSelect - 1
				end
				if const.cardSelect == 0 then
					if const.turn == 1 then
						const.turn = 2
						const.cardSelect = 15
					elseif const.turn == 2 then
						const.cardSelect = 1
						const.turn = 1
						shuffleTable(tables.p1Cards)
						shuffleTable(tables.p2Cards)
						for i=1,3,1 do
							tables.p1hand[i] = tables.p1Cards[1]
							tables.p2hand[i] = tables.p2Cards[1]
							table.remove(tables.p1Cards, 1)
							table.remove(tables.p2Cards, 1)
						end
						const.event = 4
					end
				end
				const.deltaTime = 0
			end
		end
	elseif const.event == 4 then
		if love.keyboard.isDown("x") and const.optionBox == false and const.optionBox2 == false then
			const.overallTurn = const.overallTurn + 1
			if const.turn == 1 then
				if const.deltaTime > 0.1 then
					const.turn = 2
					const.cardSelect = 1
					if table.getn(tables.p2hand) ~= 3 then
						table.insert(tables.p2hand, tables.p2Cards[1])
						table.remove(tables.p2Cards, 1)
					end
					const.deltaTime = 0
				end
			elseif const.turn == 2 then
				if const.deltaTime > 0.1 then
					const.turn = 1
					const.cardSelect = 1
					if table.getn(tables.p1hand) ~= 3 then
						table.insert(tables.p1hand, tables.p1Cards[1])
						table.remove(tables.p1Cards, 1)
					end
					const.deltaTime = 0
				end
			end
		elseif (love.keyboard.isDown("right") or love.keyboard.isDown("d")) and const.optionBox == false and const.optionBox2 == false then
			if const.deltaTime > 0.1 then
				if const.turn == 1 then
					if const.cardSelect == 9 then
						if table.getn(tables.p1hand) ~= 0 then
							const.cardSelect = 1
						else
							const.cardSelect = 4
						end
					else
						if const.cardSelect + 1 > table.getn(tables.p1hand) and const.cardSelect < 4 then
							const.cardSelect = 4
						else
							const.cardSelect = const.cardSelect + 1
						end
					end
				elseif const.turn == 2 then
					if const.cardSelect == 9 then
						if table.getn(tables.p2hand) ~= 0 then
							const.cardSelect = 1
						else
							const.cardSelect = 4
						end
					else
						if const.cardSelect + 1 > table.getn(tables.p2hand) and const.cardSelect < 4 then
							const.cardSelect = 4
						else
							const.cardSelect = const.cardSelect + 1
						end
					end
				end
				const.deltaTime = 0
			end
		elseif (love.keyboard.isDown("left") or love.keyboard.isDown("a")) and const.optionBox == false and const.optionBox2 == false then
			if const.deltaTime > 0.1 then
				if const.turn == 1 then
					if const.cardSelect == 1 then
						const.cardSelect = 9
					else
						const.cardSelect = const.cardSelect - 1
						if const.cardSelect > table.getn(tables.p1hand) and const.cardSelect < 4 then
							if table.getn(tables.p1hand) == 0 then
								const.cardSelect = 9
							else
								const.cardSelect = table.getn(tables.p1hand)
							end
						end
					end
				elseif const.turn == 2 then
					if const.cardSelect == 1 then
						const.cardSelect = 9
					else
						const.cardSelect = const.cardSelect - 1
						if const.cardSelect > table.getn(tables.p2hand) and const.cardSelect < 4 then
							if table.getn(tables.p2hand) == 0 then
								const.cardSelect = 9
							else
								const.cardSelect = table.getn(tables.p2hand)
							end
						end
					end
				end
				const.deltaTime = 0
			end
		elseif love.keyboard.isDown("up") or love.keyboard.isDown("w") then
			if const.optionBox == true then
				if const.deltaTime > 0.1 then
					if const.optionSel == 1 then
						const.optionSel = 4
					else
						const.optionSel = const.optionSel - 1
					end
					const.deltaTime = 0
				end
			elseif const.optionBox2 == true then
				if const.deltaTime > 0.1 then
					if const.optionSel == 1 then 
						const.optionSel = 2
					elseif const.optionSel == 2 then 
						const.optionSel = 1 
					end
					const.deltaTime = 0
				end
			end
		elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
			if const.optionBox == true then
				if const.deltaTime > 0.1 then
					if const.optionSel == 4 then
						const.optionSel = 1
					else
						const.optionSel = const.optionSel + 1
					end
					const.deltaTime = 0
				end
			elseif const.optionBox2 == true then
				if const.deltaTime > 0.1 then
					if const.optionSel == 1 then 
						const.optionSel = 2
					elseif const.optionSel == 2 then 
						const.optionSel = 1 
					end
					const.deltaTime = 0
				end
			end
		elseif love.keyboard.isDown("return") then
			if const.cardSelect <= 3 and const.optionBox == false and const.optionBox2 == false then
				if const.turn == 1 then
					if const.deltaTime > 0.1 then
						for i=1,3,1 do 
							if tables.p1field[i] == 0 and const.done == false then
								tables.p1field[i] = tables.p1hand[const.cardSelect]
								table.remove(tables.p1hand, const.cardSelect)
								const.done = true
							end
						end
						const.done = false
						const.deltaTime = 0
					end
				elseif const.turn == 2 then
					if const.deltaTime > 0.1 then
						for i=1,3,1 do 
							if tables.p2field[i] == 0 and const.done == false then
								tables.p2field[i] = tables.p2hand[const.cardSelect]
								table.remove(tables.p2hand, const.cardSelect)
								const.done = true
							end
						end
						const.done = false
						const.deltaTime = 0
					end
				end
				const.cardSelect = 1
			elseif const.cardSelect > 3 then
				if const.deltaTime > 0.1 then
					if const.optionBox == false and const.optionBox2 == false then
						for i=1,3,1 do
							if const.cardSelect == i+3 then
								if tables.p1field[i] ~= 0 and const.turn == 1 then
									if cards[cardIndex[tables.p1field[i]]]().cardType == 1 then
										const.optionBox = true
									elseif cards[cardIndex[tables.p1field[i]]]().cardType == 2 then
										const.optionBox2 = true
									end
								elseif tables.p2field[i] ~= 0 and const.turn == 2 then
									if cards[cardIndex[tables.p2field[i]]]().cardType == 1 then
										const.optionBox = true
									elseif cards[cardIndex[tables.p2field[i]]]().cardType == 2 then
										const.optionBox2 = true
									end
								end
							end
						end
					elseif const.optionBox == true then
						if const.optionSel == 3 then
							if const.turn == 1 then
								tables.p1field[const.cardSelect-3] = 0
							elseif const.turn == 2 then
								tables.p2field[const.cardSelect-3] = 0
							end
							const.optionBox = false
						elseif const.optionSel == 2 and const.overallTurn > 1 then
							if const.turn == 1 then
								const.conquerMode = 2
								tables.conquerfield[1] = tables.p1field[const.cardSelect-3]
								tables.p1field[const.cardSelect-3] = 0
							elseif const.turn == 2 then
								const.conquerMode = 3
								tables.conquerfield[2] = tables.p2field[const.cardSelect-3]
								tables.p2field[const.cardSelect-3] = 0
							end
							const.optionBox = false
						elseif const.optionSel == 4 then
							const.optionBox = false
						end
					elseif const.optionBox2 == true then
						if const.optionSel == 1 then
							if const.turn == 1 then
								tables.p1field[const.cardSelect-3] = 0
							elseif const.turn == 2 then
								tables.p2field[const.cardSelect-3] = 0
							end
							const.optionBox2 = false
						elseif const.optionSel == 2 then
							const.optionBox2 = false
						end
					end
					const.deltaTime = 0
				end
			end	
		end
	end
end

function love.update(dt)
	if const.event == 1 then
		const.deltaTime = const.deltaTime + dt
		if const.deltaTime > 2 then
			const.event = 2
			const.deltaTime = 0
		end
	end
	if const.control == 1 then
		mobile()
	elseif const.control == 2 then
		pc(dt)
	end
end