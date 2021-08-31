-----------------------------------
-- Area: The Boyahda Tree
--  NPC: Treasure Casket
-----------------------------------
require("scripts/globals/caskets")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.caskets.onTrigger(player, npc)
end

entity.onTrade = function(player, npc, trade)
    xi.caskets.onTrade(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.caskets.onEventFinish(player, csid, option)
end

return entity
