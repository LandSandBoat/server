-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_hexenpilz (???)
-- Spawns Hexenpilz
-- !pos -182.000 2.858 32.000 15
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.HEXENPILZ, { 2908 })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2908 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
