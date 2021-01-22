-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  -337.589 -12.248 -178.081 198
-----------------------------------
require("scripts/globals/goblinfootprint")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.goblinfootprint.rewatch(player)
end

entity.onTrigger = function(player, npc)
    tpz.goblinfootprint.rewatch(player, true)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.goblinfootprint.startEvent(player, csid, option)
end

return entity
