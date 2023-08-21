-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Goblin Mercenary
-- Note: Place holder Soulstealer Skullnix
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SOULSTEALER_SKULLNIX_PH, 5, math.random(7200, 10800)) -- 2 to 3 hours
end

return entity
