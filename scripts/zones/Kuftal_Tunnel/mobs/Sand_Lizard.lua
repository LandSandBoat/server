-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Sand Lizard
-- Note: Place Holder for Amemet
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local amemetPHTable =
{
    [ID.mob.AMEMET - 84] = ID.mob.AMEMET, -- 74.662 -0.513 3.685
    [ID.mob.AMEMET - 83] = ID.mob.AMEMET, -- 109.000 -0.010 -48.000
    [ID.mob.AMEMET - 82] = ID.mob.AMEMET, -- 92.000 -0.396 14.000
    [ID.mob.AMEMET - 22] = ID.mob.AMEMET, -- 123.046 0.250 18.642
    [ID.mob.AMEMET - 16] = ID.mob.AMEMET, -- 112.135 -0.278 38.281
    [ID.mob.AMEMET - 15] = ID.mob.AMEMET, -- 112.008 -0.530 50.994
    [ID.mob.AMEMET - 14] = ID.mob.AMEMET, -- 67.998 -0.500 12.000
    [ID.mob.AMEMET - 13] = ID.mob.AMEMET, -- 89.590 -0.321 -9.390
    [ID.mob.AMEMET - 12] = ID.mob.AMEMET, -- 123.186 0.213 -24.716
    [ID.mob.AMEMET - 11] = ID.mob.AMEMET, -- 96.365 -0.269 -7.619
    [ID.mob.AMEMET - 8]  = ID.mob.AMEMET, -- 122.654 -0.491 0.840
    [ID.mob.AMEMET - 7]  = ID.mob.AMEMET, -- 68.454 -0.417 -0.413
    [ID.mob.AMEMET - 6]  = ID.mob.AMEMET, -- 118.633 -0.470 -43.282
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 735, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, amemetPHTable, 5, math.random(7200, 43200)) -- 2 to 12 hours
end

return entity
