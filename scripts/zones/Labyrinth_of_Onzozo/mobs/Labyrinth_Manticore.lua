-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Labyrinth Manticore
-- Note: Place holder Narasimha
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 775, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NARASIMHA, 10, 21600) -- 6 hours
end

return entity
