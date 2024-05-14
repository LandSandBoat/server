-----------------------------------
-- Area: Cape Teriggan
--  Mob: Greater Manticore
-- Note: Place Holder for Frostmane
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
-----------------------------------
local entity = {}

local frostmanePHTable =
{
    [ID.mob.FROSTMANE - 5] = ID.mob.FROSTMANE, -- -262.000 -0.700 442.000
    [ID.mob.FROSTMANE - 4] = ID.mob.FROSTMANE, -- -272.224 -0.942 461.321
    [ID.mob.FROSTMANE - 3] = ID.mob.FROSTMANE, -- -268.000 -0.558 440.000
    [ID.mob.FROSTMANE - 2] = ID.mob.FROSTMANE, -- -283.874 -0.660 485.504
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 108, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, frostmanePHTable, 5, math.random(3600, 21600)) -- 1 to 6 hours
end

return entity
