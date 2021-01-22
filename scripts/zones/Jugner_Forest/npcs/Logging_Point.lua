-----------------------------------
-- Area: Jugner Forest
--  NPC: Logging Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.LOGGING, 20)
end

entity.onTrigger = function(player, npc)
    tpz.helm.onTrigger(player, tpz.helm.type.LOGGING)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
