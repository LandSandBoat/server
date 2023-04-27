-----------------------------------
-- Area: Caedarva Mire
--  NPC: Seaprince's Tombstone
-- Involved in quest: Forging a New Myth
-- !pos  -433 7 -586 79
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/npc_util")
require("scripts/globals/status")
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local tinninsFang = npcUtil.tradeHas(trade, 2609)
	local sarameyasHide = npcUtil.tradeHas(trade, 2619)
	local tygersTail = npcUtil.tradeHas(trade, 2629)
	local gurfurlursHelmet = npcUtil.tradeHas(trade, 2356)
	local medusasArmlet = npcUtil.tradeHas(trade, 2357)
	local jajasChestplate = npcUtil.tradeHas(trade, 2355)
	local imperialGoldPieces = trade:hasItemQty(2187, 99)
	local catsEye = npcUtil.tradeHas(trade, 3443)
	local titleCheck = (player:hasTitle(xi.title.CERBERUS_MUZZLER) and player:hasTitle(xi.title.HYDRA_HEADHUNTER) and player:hasTitle(xi.title.KHIMAIRA_CARVER) and
    player:hasTitle(xi.title.GORGONSTONE_SUNDERER) and player:hasTitle(xi.title.GORGONSTONE_SUNDERER) and player:hasTitle(xi.title.SHINING_SCALE_RIFLER))
	
	if (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18971)) then -- conqueror
	    player:setCharVar("MythicReward", 18991)
		player:tradeComplete()
		player:startEvent(25, 1)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18972)) then -- glanzfaust
	    player:setCharVar("MythicReward", 18992)
	    player:tradeComplete()
		player:startEvent(25, 2)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18973)) then -- yagrush
	    player:setCharVar("MythicReward", 18993)
	    player:tradeComplete()
		player:startEvent(25, 3)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18974)) then -- laevateinn
	    player:setCharVar("MythicReward", 18994)
	    player:tradeComplete()
		player:startEvent(25, 4)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18975)) then -- murgleis
	    player:setCharVar("MythicReward", 18995)
	    player:tradeComplete()
		player:startEvent(25, 5)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18976)) then -- vajra
	    player:setCharVar("MythicReward", 18996)
	    player:tradeComplete()
		player:startEvent(25, 6)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18977)) then -- burtgang
	    player:setCharVar("MythicReward", 18997)
	    player:tradeComplete()
		player:startEvent(25, 7)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18978)) then -- liberator
	    player:setCharVar("MythicReward", 18998)
	    player:tradeComplete()
		player:startEvent(25, 8)
 	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18979)) then -- aymur
	    player:setCharVar("MythicReward", 18999)
	    player:tradeComplete()
		player:startEvent(25, 9)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18980)) then -- carnwenhan
	    player:setCharVar("MythicReward", 19000)
	    player:tradeComplete()
		player:startEvent(25, 10)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18981)) then -- gastraphetes
	    player:setCharVar("MythicReward", 19001)
	    player:tradeComplete()
		player:startEvent(25, 11)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18982)) then -- kogarasumaru
	    player:setCharVar("MythicReward", 19002)
	    player:tradeComplete()
		player:startEvent(25, 12)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18983)) then -- nagi
	    player:setCharVar("MythicReward", 19003)
	    player:tradeComplete()
		player:startEvent(25, 13)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18984)) then -- ryunohige
	    player:setCharVar("MythicReward", 19004)
	    player:tradeComplete()
		player:startEvent(25, 14)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18985)) then -- nirvana
	    player:setCharVar("MythicReward", 19005)
	    player:tradeComplete()
		player:startEvent(25, 15)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18986)) then -- tizona
	    player:setCharVar("MythicReward", 19006)
	    player:tradeComplete()
		player:startEvent(25, 16)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18987)) then -- death_penalty
	    player:setCharVar("MythicReward", 19007)
	    player:tradeComplete()
		player:startEvent(25, 17)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18988)) then -- kenkonken
	    player:setCharVar("MythicReward", 19008)
	    player:tradeComplete()
		player:startEvent(25, 18)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18969)) then -- terpsichore
	    player:setCharVar("MythicReward", 18989)
	    player:tradeComplete()
		player:startEvent(25, 19)
	elseif (player:getCharVar("PendingMythic") == 1 and npcUtil.tradeHasExactly(trade, 18970)) then -- tupsimati
	    player:setCharVar("MythicReward", 18990)
	    player:tradeComplete()
		player:startEvent(25, 20)
	elseif (titleCheck == true and tinninsFang and sarameyasHide and tygersTail and gurfurlursHelmet and medusasArmlet and jajasChestplate and catsEye and imperialGoldPieces) then
		player:tradeComplete()
		player:setCharVar("PendingMythic", 1)
		player:PrintToPlayer("Balrahn Eidolon: I have nearly everything I need... Come back with your base weapon to complete the upgrade.", 0xD)
	end	
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SEAPRINCES_TOMBSTONE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
	if csid == 25 then
	    if player:getCharVar("MythicReward") == 18991 then
         	player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    	    player:addItem(18991)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18991)	
	    elseif player:getCharVar("MythicReward") == 18992 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18992)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18992)
	    elseif player:getCharVar("MythicReward") == 18993 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18993)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18993)	
	    elseif player:getCharVar("MythicReward") == 18994 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18994)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18994)
	    elseif player:getCharVar("MythicReward") == 18995 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18995)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18995)
	    elseif player:getCharVar("MythicReward") == 18996 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18996)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18996)	
	    elseif player:getCharVar("MythicReward") == 18997 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18997)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18997)
	    elseif player:getCharVar("MythicReward") == 18998 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18998)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18998)
	    elseif player:getCharVar("MythicReward") == 18999 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18999)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18999)
	    elseif player:getCharVar("MythicReward") == 19000 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19000)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19000)
	    elseif player:getCharVar("MythicReward") == 19001 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19001)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19001)
	    elseif player:getCharVar("MythicReward") == 19002 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19002)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19002)
	    elseif player:getCharVar("MythicReward") == 19003 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19003)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19003)
	    elseif player:getCharVar("MythicReward") == 19004 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19004)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19004)
	    elseif player:getCharVar("MythicReward") == 19005 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19005)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19005)
	    elseif player:getCharVar("MythicReward") == 19006 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19006)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19006)
	    elseif player:getCharVar("MythicReward") == 19007 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19007)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19007)
	    elseif player:getCharVar("MythicReward") == 19008 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(19008)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 19008)
	    elseif player:getCharVar("MythicReward") == 18989 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18989)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18989)
	    elseif player:getCharVar("MythicReward") == 18990 then
     	    player:setCharVar("PendingMythic", 0)
			player:setCharVar("MythicReward", 0)
    		player:addItem(18990)
    		player:messageSpecial(ID.text.ITEM_OBTAINED, 18990)	
        end
	end	
end

return entity
