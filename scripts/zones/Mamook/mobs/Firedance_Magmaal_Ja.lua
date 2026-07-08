-----------------------------------
-- Area: Mamook
--   NM: Firedance Magmaal Ja
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -209.000, y =  19.000, z = -388.000 }
}

entity.phList =
{
    [ID.mob.FIREDANCE_MAGMAAL_JA - 6] = ID.mob.FIREDANCE_MAGMAAL_JA, -- -201.522 17.209 -363.865
    [ID.mob.FIREDANCE_MAGMAAL_JA - 5] = ID.mob.FIREDANCE_MAGMAAL_JA, -- -206.458 17.525 -373.798
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 461)
end

return entity
