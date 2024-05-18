-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Brook Sahagin
-- Note: PH for Qull the Shellbuster
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local entity = {}

local qullPHTable =
{
    [ID.mob.QULL_THE_SHELLBUSTER - 5] = ID.mob.QULL_THE_SHELLBUSTER, -- 348.293 10.133 -65.543
    [ID.mob.QULL_THE_SHELLBUSTER - 2] = ID.mob.QULL_THE_SHELLBUSTER, -- 363.430 10.578 -62.752
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 806, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 807, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 808, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, qullPHTable, 10, 7200) -- 2 hours
end

return entity
