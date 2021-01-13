-----------------------------------
-- Area: Jugner Forest
--  Mob: Stag Beetle
-- Note: PH for Panzer Percival
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 12, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 13, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.PANZER_PERCIVAL_PH, 10, 3600) -- 1 hour
end

return entity
