-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Giant Gatekeeper
-- Note: PH for Epialtes and Hippolytos
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 778, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.EPIALTES_PH, 5, 1) -- no cooldown
    tpz.mob.phOnDespawn(mob, ID.mob.HIPPOLYTOS_PH, 5, 1) -- no cooldown
end

return entity
