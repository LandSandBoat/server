-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sabotender Bailaor
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 816, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SABOTENDER_BAILARIN_PH, 10, 9000) -- 2.5 hours
end

return entity
