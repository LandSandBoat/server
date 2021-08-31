-----------------------------------
-- Area: Rabao
--  NPC: Hunt Registry
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.hunts.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.hunts.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.hunts.onEventFinish(player, csid, option)
end

return entity
