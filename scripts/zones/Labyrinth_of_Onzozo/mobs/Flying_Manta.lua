-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Flying Manta
-- Note: PH for Lord of Onzozo and Peg Powler
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 774, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.LORD_OF_ONZOZO, 4, 57600) -- 16 hour minimum
    xi.mob.phOnDespawn(mob, ID.mob.PEG_POWLER, 4, 7200) -- 2 hour minimum
end

return entity
