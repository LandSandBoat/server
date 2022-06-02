-----------------------------------
-- Area: Lower Jeuno
--  NPC: Hunter (Nantoto)
-----------------------------------
require("scripts/globals/missions")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.CHAINS_AND_BONDS then
	    player:PrintToPlayer("Busted mission detected. Skipping ...")
		player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)
		player:setMissionStatus(xi.mission.log_id.COP, 0)
		player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)
		player:PrintToPlayer("Nantoto: You should now be on \"Flames in the Darkness\".", 0xD)
    elseif player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN then
	    player:PrintToPlayer("Busted mission detected. Skipping ...")
		player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
		player:setMissionStatus(xi.mission.log_id.COP, 0)
		player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
		player:PrintToPlayer("Nantoto: You should now be on \"The Last Verse\".", 0xD)
    elseif player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY then
	    player:PrintToPlayer("Busted mission detected. Fixing ...")
		player:setCharVar("PromathiaStatus", 1)
		player:PrintToPlayer("Nantoto: Go check the Crystalline field again for Cutscene and continue...", 0xD)
	else
	    player:PrintToPlayer("Nantoto: Get out of here!", 0xD)
	end	
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
