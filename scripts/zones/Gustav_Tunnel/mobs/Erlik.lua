-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Erlik
-- Note: Place holder Baobhan Sith
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
local entity = {}

local baobhanPHTable =
{
    [ID.mob.BAOBHAN_SITH - 2] = ID.mob.BAOBHAN_SITH, -- 171.000 9.194 55.000
    [ID.mob.BAOBHAN_SITH - 1] = ID.mob.BAOBHAN_SITH, -- 187.000 9.000 105.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 767, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, baobhanPHTable, 5, math.random(14400, 28800)) -- 4 to 8 hours
end

return entity
