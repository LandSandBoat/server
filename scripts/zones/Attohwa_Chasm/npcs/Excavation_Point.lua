-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Excavation Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.EXCAVATION, 10)
end

entity.onTrigger = function(player, npc)
    tpz.helm.onTrigger(player, tpz.helm.type.EXCAVATION)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
