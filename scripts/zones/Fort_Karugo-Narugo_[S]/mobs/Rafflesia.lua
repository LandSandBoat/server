-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Rafflesia
-- Note: PH for Kirtimukha
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local kirtimukhaPHTable =
{
    [ID.mob.KIRTIMUKHA - 8] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 7] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 6] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 5] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 4] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 3] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 1] = ID.mob.KIRTIMUKHA,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, kirtimukhaPHTable, 5, 3600) -- 1 hour
end

return entity
