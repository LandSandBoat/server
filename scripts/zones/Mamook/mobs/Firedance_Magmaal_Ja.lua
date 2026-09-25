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
    [ID.mob.FIREDANCE_MAGMAAL_JA - 9] = ID.mob.FIREDANCE_MAGMAAL_JA, -- Confirmed on retail
    [ID.mob.FIREDANCE_MAGMAAL_JA - 6] = ID.mob.FIREDANCE_MAGMAAL_JA, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 461)
end

return entity
