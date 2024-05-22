-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Reaper
-- Note: Place holder Goblinsavior Heronox
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
local entity = {}

local goblinsaviorPHTable =
{
    [ID.mob.GOBLINSAVIOR_HERONOX - 17] = ID.mob.GOBLINSAVIOR_HERONOX, -- 153.000 -10.000 -53.000
    [ID.mob.GOBLINSAVIOR_HERONOX - 4]  = ID.mob.GOBLINSAVIOR_HERONOX, -- 152.325 -10.702 -77.007
    [ID.mob.GOBLINSAVIOR_HERONOX - 5]  = ID.mob.GOBLINSAVIOR_HERONOX, -- 165.558 -10.647 -68.537
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 764, 3, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 765, 3, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, goblinsaviorPHTable, 5, math.random(10800, 18000)) -- 3 to 5 hours
end

return entity
