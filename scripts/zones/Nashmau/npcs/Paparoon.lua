-----------------------------------
-- Area: Nashmau
--  NPC: Paparoon
-- Standard Info NPC
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local alexandrite = 2488
	local alexCount = trade:getItemCount()
	local storedAlex = player:getCharVar("Paparoon_AlexStored")
	
	-- check to see if player already has alex stored, if he does we'll add to his total --
	if (storedAlex and npcUtil.tradeHasOnly(trade, alexandrite)) then
	    local newStoredAlex = storedAlex + alexCount
	    player:setCharVar("Paparoon_AlexStored", newStoredAlex)
		player:PrintToPlayer(string.format("Paparoon: That makes a total of %i alexandrite stored!", newStoredAlex), 0xD)
		player:tradeComplete()
	elseif not storedAlex then
        player:setCharVar("Paparoon_AlexStored", alexCount)
		player:PrintToPlayer(string.format("Paparoon: I guess this is better than nothin'... You have %i alexandrite stored!", storedAlex), 0xD)
		player:tradeComplete()
	end
end

entity.onTrigger = function(player, npc)
    local storedAlex = player:getCharVar("Paparoon_AlexStored")
	
	-- tell the player how many alex they have stored, if any --
	if (storedAlex) then 
	    player:PrintToPlayer(string.format("Paparoon: How many times are you going to ask?? You have %i alexandrite stored!", storedAlex), 0xD)
	end
	
    --player:startEvent(26)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
