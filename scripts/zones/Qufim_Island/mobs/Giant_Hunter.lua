-----------------------------------
-- Area: Qufim Island
--  Mob: Giant Hunter
-- Note: PH for Slippery Sucker
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 44, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 45, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SLIPPERY_SUCKER_PH, 10, 600) -- 10 minutes
end

return entity
