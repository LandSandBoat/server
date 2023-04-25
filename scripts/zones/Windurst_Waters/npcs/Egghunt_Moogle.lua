-----------------------------------
-- Area: Windurst Waters
--  NPC: Moogle
-- Type: Special Events Moogle
-----------------------------------
require("scripts/globals/events/egg_hunt_egg-stravaganza")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.egg_hunt.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.events.egg_hunt.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.events.egg_hunt.onEventFinish(player, csid, option)
end

return entity
