-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Gigas Quarrier
-- Note: PH for Rhoikos
-----------------------------------
local ID = require("scripts/zones/Middle_Delkfutts_Tower/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 783, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 784, 2, tpz.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.RHOIKOS_PH, 5, math.random(7200, 14400)) -- 2 to 4 hours (could not find info, so using Ogygos' cooldown)
end

return entity
