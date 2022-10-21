-----------------------------------
-- Area: QuBia_Arena
--  Mob: Vangknok of Clan Death
-- Mission 9-2 San d'Oria
-----------------------------------
local global = require("scripts/zones/QuBia_Arena/Globals")
local ID = require("scripts/zones/QuBia_Arena/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    global.tryPhaseChange(player)
end

entity.onEventFinish = function(player, csid, option)
    global.phaseEventFinish(player, csid)
end

return entity
