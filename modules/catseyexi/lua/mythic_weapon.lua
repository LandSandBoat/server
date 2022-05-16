-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("mythic_weapon")

m:addOverride("xi.zones.Nashmau.npcs.Paparoon.onTrade", function(player, npc, trade)
    local alexandrite = 2488
	local catsEye = 3443
	local alexCount = trade:getItemCount()
	local storedAlex = player:getCharVar("Paparoon_AlexStored")
	local hasCaptain = (player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) == true)
	--local hasCompletedTOAU = player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.PREVALENCE_OF_PIRATES)
	
	-- check to see if player already has alex stored, if he does we'll add to his total --
	if (storedAlex and npcUtil.tradeHasOnly(trade, alexandrite)) then
	    local newStoredAlex = storedAlex + alexCount
	    player:setCharVar("Paparoon_AlexStored", newStoredAlex)
	-- exchange alexandrite for alex if we're at 30000 --
		if (newStoredAlex >= 30000 and hasCaptain) then
		    player:tradeComplete()
		    player:setCharVar("Paparoon_AlexStored", (newStoredAlex - 30000))
		    player:PrintToPlayer("Paparoon: 1...2...3...30,0000! That's unreal yo!", 0xD)
			player:messageSpecial( ID.text.ITEM_OBTAINED, catsEye )
			player:addItem(catsEye)
    	elseif (newStoredAlex >= 30000 and not hasCaptain) then
		    player:tradeComplete()
		    player:PrintToPlayer("Paparoon: You still not a captain?! Come back when you are!", 0xD)
		    return
    	elseif not storedAlex then
            player:setCharVar("Paparoon_AlexStored", alexCount)
	    	player:PrintToPlayer(string.format("Paparoon: I guess this is better than nothin'... You have %i alexandrite stored!", storedAlex), 0xD)
	    	player:tradeComplete()
			return 
		else
	        player:PrintToPlayer(string.format("Paparoon: That makes a total of %i alexandrite stored!", newStoredAlex), 0xD)
		    player:tradeComplete()
			return
	    end
    end
end)

m:addOverride("xi.zones.Nashmau.npcs.Paparoon.onTrigger", function(player, npc)
    local storedAlex = player:getCharVar("Paparoon_AlexStored")
	local hasCaptain = (player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) == true)
	local catsEye = 3443
	
	-- tell the player how many alex they have stored, if any --
	if storedAlex == nil then
	    player:PrintToPlayer("Paparoon: Do I know you?! Back off yo!", 0xD)
	elseif storedAlex < 30000 then
	    player:PrintToPlayer(string.format("Paparoon: How many times are you going to ask?? You have %i alexandrite stored!", storedAlex), 0xD)
	elseif (storedAlex >= 30000 and not hasCaptain) then 
        player:PrintToPlayer("Paparoon: You still not a captain?! Come back when you are!", 0xD)
	elseif (storedAlex >= 30000 and hasCaptain) then
		player:setCharVar("Paparoon_AlexStored", (storedAlex - 30000))
		player:PrintToPlayer("Paparoon: 1...2...3...30,0000! That's unreal yo!", 0xD)
		player:messageSpecial( ID.text.ITEM_OBTAINED, catsEye )
		player:addItem(catsEye)
	end
end)

m:addOverride("xi.zones.Caedarva_Mire.npcs.Seaprinces_Tombstone.onTrade", function(player, npc, trade)
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
end)

m:addOverride("xi.zones.Caedarva_Mire.npcs.Seaprinces_Tombstone.onEventFinish", function(player, csid, option)
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
end)

return m 