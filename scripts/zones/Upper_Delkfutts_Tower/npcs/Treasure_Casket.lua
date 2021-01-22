-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: Treasure Casket
-----------------------------------
require("scripts/globals/caskets")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    tpz.caskets.onTrigger(player, npc)
end

entity.onTrade = function(player, npc, trade)
    tpz.caskets.onTrade(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.caskets.onEventFinish(player, csid, option)
end

return entity
