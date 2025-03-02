-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Robber Crab
-- Note: PH for Aquarius
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

local aquariusPHTable =
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

local aquariusSpawnPoints =
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

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 720, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.spawnPoints = aquariusSpawnPoints
    xi.mob.phOnDespawn(mob, aquariusPHTable, 5, 1, params) -- can repop instantly
end

return entity
