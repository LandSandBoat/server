-----------------------------------
-- Area: Port Jeuno
--  NPC: Cumetouflaix
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/missions")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
local hasCompletedCoP = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
local hasCompletedZM = player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS)
local hasCompletedTOAU = player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_EMPRESS_CROWNED)
local ancientBeastcoin = 1875

    if player:getFreeSlotsCount() == 0 then
        player:PrintToPlayer("Please come back after sorting your inventory.", 0xD)
        return
	end
	
-- Start tier 1 rewards 100 - 106 coins --	
    if (hasCompletedCoP and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 100}})) then
        player:tradeComplete()
        player:addItem(15545) -- Tamas Ring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Tamas Ring\"!", 0xD)
    elseif (hasCompletedCoP and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 101}})) then
		player:tradeComplete()
        player:addItem(15543) -- Rajas Ring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Rajas Ring\"!", 0xD)
    elseif (hasCompletedCoP and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 102}})) then
		player:tradeComplete()
        player:addItem(15544) -- Sattva Ring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Sattva Ring\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 103}})) then
	    player:tradeComplete()
		player:addItem(15962) -- Static Earring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Static Earring\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 104}})) then
	    player:tradeComplete()
		player:addItem(15963) -- Magnetic Earring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Magnetic Earring\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 105}})) then
	    player:tradeComplete()
		player:addItem(15964) -- Hollow Earring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Hollow Earring\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 106}})) then
	    player:tradeComplete()
		player:addItem(15965) -- Ethereal Earring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Ethereal Earring\"!", 0xD)

-- Add Trust: Ark EV as reward
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 200}})) then
	    player:tradeComplete()
		player:addItem(10191) -- cipher: Ark EV
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Cipher: Ark EV\"!", 0xD)

-- Add Trust: Maximilian as reward
	elseif (hasCompletedZM and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 201}})) then
	    player:tradeComplete()
		player:addItem(10164) -- cipher: Maximilian
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Cipher: Maximilian\"!", 0xD)

-- Start tier 2 rewards 250 - 254 coins --
    elseif (hasCompletedZM and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 250}})) then
		player:tradeComplete()
        player:addItem(14741) -- Abyssal Earring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Abyssal Earring\"!", 0xD)
    elseif (hasCompletedZM and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 251}})) then
		player:tradeComplete()
        player:addItem(14742) -- Beastly Earring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Beastly Earring\"!", 0xD)
    elseif (hasCompletedZM and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 252}})) then
		player:tradeComplete()
        player:addItem(14743) -- Bushonomimi
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Bushonomimi\"!", 0xD)
    elseif (hasCompletedZM and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 253}})) then
		player:tradeComplete()
        player:addItem(14740) -- Knights Earring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Knights Earring\"!", 0xD)
    elseif (hasCompletedZM and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 254}})) then
		player:tradeComplete()
        player:addItem(14739) -- Suppanomimi
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Suppanomimi\"!", 0xD)
		
-- Start tier 3 rewards 500 - 506 coins --
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 500}})) then
	    player:tradeComplete()
		player:addItem(15458) -- Ninurta's Sash
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Ninurta's Sash\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 501}})) then
	    player:tradeComplete()
		player:addItem(15548) -- Mars's Ring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Mars's Ring\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 502}})) then
	    player:tradeComplete()
		player:addItem(17810) -- Futsuno Mitama
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Futsuno Mitama\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 503}})) then
	    player:tradeComplete()
		player:addItem(15549) -- Bellona's Ring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Bellona's Ring\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 504}})) then
	    player:tradeComplete()
		player:addItem(18245) -- Aureole
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Aureole\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 505}})) then
	    player:tradeComplete()
		player:addItem(18398) -- Raphael's Rod
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Raphael's Rod\"!", 0xD)
	elseif (hasCompletedZM and hasCompletedCoP and hasCompletedTOAU and npcUtil.tradeHasExactly(trade, {{ancientBeastcoin, 506}})) then
	    player:tradeComplete()
		player:addItem(15550) -- Minerva's Ring
		player:PrintToPlayer("Cumetouflaix: Great work adventurer, I reward thee with \"Minerva's Ring\"!", 0xD)
	end
	
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.CUMETOUFLAIX_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity