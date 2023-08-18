-----------------------------------
-- Area: QuBia_Arena
--  Mob: Rallbrog of Clan Death
-- Mission 9-2 San d'Oria
-----------------------------------
local global = require("scripts/zones/QuBia_Arena/Globals")
local ID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    global.tryPhaseChange(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    global.phaseEventFinish(player, csid)
end

return entity
