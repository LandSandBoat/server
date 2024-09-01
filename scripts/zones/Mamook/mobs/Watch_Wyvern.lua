-----------------------------------
-- Area: Mamook
--  Mob: Watch Wyvern
-- Note: PH for Firedance Magmaal Ja
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

local firedancePHTable =
{
    [ID.mob.FIREDANCE_MAGMAAL_JA - 6] = ID.mob.FIREDANCE_MAGMAAL_JA, -- -201.522 17.209 -363.865
    [ID.mob.FIREDANCE_MAGMAAL_JA - 5] = ID.mob.FIREDANCE_MAGMAAL_JA, -- -206.458 17.525 -373.798
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, firedancePHTable, 5, 3600) -- 1 hour
end

return entity
