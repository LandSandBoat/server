-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Goblin Mercenary
-- Note: Place holder Wyvernpoacher Drachlox
-----------------------------------
local ID = zones[xi.zone.GUSTAV_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local wyvernpoacherPHTable =
{
    [ID.mob.WYVERNPOACHER_DRACHLOX - 7] = ID.mob.WYVERNPOACHER_DRACHLOX, -- -100.000 1.000 -44.000
    [ID.mob.WYVERNPOACHER_DRACHLOX - 6] = ID.mob.WYVERNPOACHER_DRACHLOX, -- -101.000 1.000 -29.000
    [ID.mob.WYVERNPOACHER_DRACHLOX + 4] = ID.mob.WYVERNPOACHER_DRACHLOX, -- -165.598 0.218 -21.966
    [ID.mob.WYVERNPOACHER_DRACHLOX + 3] = ID.mob.WYVERNPOACHER_DRACHLOX, -- -150.673 -0.067 -20.914
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 764, 3, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 765, 3, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, wyvernpoacherPHTable, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
