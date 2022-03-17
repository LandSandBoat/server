-----------------------------------
-- Area: Lower Jeuno
--  NPC: EXP Guide (Shomera)
-- !pos -4.104 0.000 -7.085 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
    local coins = trade:getGil()
	local hasWarpScroll = player:hasItem(4181)
	
	-- check to see if our player has a warp scroll, if not, give them one.
	if not hasWarpScroll then
	    npcUtil.giveItem(player, xi.items.SCROLL_OF_INSTANT_WARP) -- scroll_of_instant_warp
	end
	
	if (npcUtil.tradeHasExactly(trade, {{ 'gil', 1 }})) then
	    player:setPos(128.163, -7.320, 95.083, 0, 103) -- Valkurm Dunes
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 2 }})) then
	    player:setPos(-54.956, -20.000, 63.757, 0, 126) -- Qufim Pond
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 3 }})) then
	    player:setPos(-31.682, -20.026, 258.653, 0, 126) -- Qufim Pugils
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 4 }})) then
	    player:setPos(-224.635, -0.255, 503.703, 0, 123) -- Yuhtunga Jungle
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 5 }})) then
	    player:setPos(-278.584, 8.300, 140.543, 0, 124) -- Yhoator Jungle
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 6 }})) then
	    player:setPos(-341.194, -3.250, 340.712, 0, 200) -- Garlaige Citadel
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 7 }})) then
	    player:setPos(345.456, -32.374, -19.874, 0, 197) -- Crawler's Nest
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 8 }})) then
	    player:setPos(-140.079, -13.407, 19.703, 0, 125) -- Western Altepa Desert
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 9 }})) then
	    player:setPos(-16.756, 0.000, -181.055, 0, 213) -- Labyrinth of Onzozo
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 10 }})) then
        player:setPos(-237.550, -15.855, 86.347, 0, 51) -- Wajaom Woodlands	
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 11 }})) then
        player:setPos(-33.094, 4.770, 139.340, 0, 213) -- Labyrinth of Onzozo	
	elseif (npcUtil.tradeHasExactly(trade, {{ 'gil', 12 }})) then
        player:setPos(17.172, -10.547, 8.043, 0, 174) -- Kuftal Tunnel
	end
end

entity.onTrigger = function(player, npc)
    local name = player:getName()
    player:PrintToPlayer(string.format("EXP Guide: Greetings, %s! I am your Experience Guide. I send adventurers like yourself to various EXP camps around Vana'diel!", name), 0xD)
	player:PrintToPlayer("Trade me the corresponding amount of gil, and I'll get you to the hunting camp of your choice lickity split!\n", 0xD)
	player:PrintToPlayer("Recommended levels below are intended for EXP parties. Your mileage may vary! ^.^b\n")
	player:PrintToPlayer("1 gil = Valkurm Dunes (Level 12 - 18)", 0xD)
	player:PrintToPlayer("2 gil = Qufim Island (Pond) (Level 19 - 22)", 0xD)
	player:PrintToPlayer("3 gil = Qufim Island (Pugil Camp) (Level 23 - 25)", 0xD)
	player:PrintToPlayer("4 gil = Yuhutunga Jungle (Level 26 - 28)", 0xD)
	player:PrintToPlayer("5 gil = Yhoator Jungle (Level 29 - 32)", 0xD)
	player:PrintToPlayer("6 gil = Garlaige Citadel (Level 33 - 36)", 0xD)
    player:PrintToPlayer("7 gil = Crawler's Nest (Level 37 - 43)", 0xD)
	player:PrintToPlayer("8 gil = Western Altepa Desert (Level 44 - 50)", 0xD)
	player:PrintToPlayer("9 gil = Labyrinth of Onzozo (51-54)", 0xD)
	player:PrintToPlayer("10 gil = Wajaom Woodlands (Level 55 - 59)", 0xD)
	player:PrintToPlayer("11 gil = Labyrinth of Onzozo (Level 60 - 69)", 0xD)
	player:PrintToPlayer("12 gil = Kuftal Tunnel (Level 70 - 75)", 0xD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
