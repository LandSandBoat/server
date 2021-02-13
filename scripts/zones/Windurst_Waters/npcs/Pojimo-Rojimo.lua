-----------------------------------
-- Area: Windurst Waters
--  NPC: Pojimo-Rojimo
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(560)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
