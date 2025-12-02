-----------------------------------
-- Area: The Boyahda Tree
--   NM: Aquarius
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.AQUARIUS - 7] = ID.mob.AQUARIUS, -- 170.97 9.414 -12.579
    [ID.mob.AQUARIUS - 6] = ID.mob.AQUARIUS, -- 174.99 9.589 -16.718
    [ID.mob.AQUARIUS - 5] = ID.mob.AQUARIUS, -- 182.40 8.707 -33.993
    [ID.mob.AQUARIUS - 3] = ID.mob.AQUARIUS, -- 163.31 9.590 -58.550
    [ID.mob.AQUARIUS - 2] = ID.mob.AQUARIUS, -- 162.88 9.591 -58.082
    [ID.mob.AQUARIUS - 1] = ID.mob.AQUARIUS, -- 195.37 8.972 -73.536
    [ID.mob.AQUARIUS + 2] = ID.mob.AQUARIUS, -- 149.30 9.742 -64.239
    [ID.mob.AQUARIUS + 3] = ID.mob.AQUARIUS, -- 146.14 9.712 -51.616
    [ID.mob.AQUARIUS + 4] = ID.mob.AQUARIUS, -- 149.59 9.765 -61.490
}

entity.spawnPoints =
{
    { x = 165.930, y = 9.344, z = -56.348 },
    { x = 162.448, y = 9.620, z = -55.495 },
    { x = 164.711, y = 9.541, z = -66.727 },
    { x = 178.612, y = 9.296, z = -73.433 },
    { x = 193.725, y = 9.425, z = -70.498 },
    { x = 193.785, y = 9.346, z = -54.751 },
    { x = 187.045, y = 9.514, z = -46.248 },
    { x = 177.735, y = 9.537, z = -44.149 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.POISON)
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 358)
end

return entity
