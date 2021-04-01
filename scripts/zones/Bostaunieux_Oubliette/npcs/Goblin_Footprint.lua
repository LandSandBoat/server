-----------------------------------
-- Area: Bostaunieux Oubliette
--  NPC: Goblin Footprint
-- Type: NPC
-- !pos  111.806 -24.007 57.266 167
-----------------------------------
require("scripts/globals/goblinfootprint")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.goblinfootprint.rewatch(player)
end

entity.onTrigger = function(player, npc)
    xi.goblinfootprint.rewatch(player, true)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.goblinfootprint.startEvent(player, csid, option)
end

return entity
