-----------------------------------
-- Area: Mhaura
--  NPC: Keshab-Menjab
-- Type: Standard NPC
-- !pos -15.727 -9.032 54.049 249
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(313)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
