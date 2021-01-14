-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Gigas Bonecutter
-- Note: PH for Enkelados
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 785, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ENKELADOS_PH, 5, 1) -- no cooldown
end

return entity
