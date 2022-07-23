------------------------------------
-- Override specific mission/quest functions
-----------------------------------
require("modules/module_utils")
require("scripts/globals/status")
require("scripts/globals/missions")
-----------------------------------
local m = Module:new("cop_chapter_8_fixes")

-- 8-1 Towers
m:addOverride("xi.zones.AlTaieu.npcs._0x1.onTrigger", function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY then
        player:setCharVar("[SEA][AlTieu]SouthTowerCS", 1)
    	player:PrintToPlayer("You may now go visit the West Tower.")
    end
end)

m:addOverride("xi.zones.AlTaieu.npcs._0x2.onTrigger", function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY then
        player:setCharVar("[SEA][AlTieu]WestTowerCS", 1)
    	player:PrintToPlayer("You may now go visit the East Tower.")
    end	
end)

m:addOverride("xi.zones.AlTaieu.npcs._0x3.onTrigger", function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY then
        player:setCharVar("[SEA][AlTieu]EastTowerCS", 1)
	    player:PrintToPlayer("You may now return to the Crystalline Field.")
	end	
end)

m:addOverride("xi.zones.AlTaieu.npcs._0x3.onTrigger", function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.GARDEN_OF_ANTIQUITY then
        player:setCharVar("[SEA][AlTieu]EastTowerCS", 1)
		player:setCharVar("PromathiaStatus", 3)
	    player:PrintToPlayer("You may now return to the Crystalline Field.")
	end
end)

return m