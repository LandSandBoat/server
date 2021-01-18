-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  -129.021 -25.127 -601.431 119
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
