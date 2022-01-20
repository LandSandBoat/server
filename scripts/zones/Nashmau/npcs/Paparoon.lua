-----------------------------------
-- Area: Nashmau
--  NPC: Paparoon
-- Standard Info NPC
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Nashmau/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
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
end

entity.onTrigger = function(player, npc)
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
end
	
    --player:startEvent(26)

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
