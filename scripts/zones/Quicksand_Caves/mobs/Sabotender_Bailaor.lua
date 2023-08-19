-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sabotender Bailaor
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 816, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SABOTENDER_BAILARIN_PH, 100, 9000) -- 2.5 hours
end

return entity
