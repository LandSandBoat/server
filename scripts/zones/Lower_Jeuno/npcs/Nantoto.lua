-----------------------------------
-- Area: Lower Jeuno
--  NPC: Hunter (Nantoto)
-----------------------------------
require("scripts/globals/utils")

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local playerNation = player:getNation()
	if player:getCurrentMission(xi.mission.log_id.playerNation) == 23 and player:getNation() == 0
	then -- Heir to the Light 9-2
	    print("Broken Mission Detected")
		player:setMissionStatus(0, 6)
		player:PrintToPlayer("Sending you to King Ranperres Tomb. Click the Heavy Stone Door to progress...")
		player:timer(3500, function(player)
		    player:setPos(-35.699, 7.50, 19.997, 131, 190)
		end)
	end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
