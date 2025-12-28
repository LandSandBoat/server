-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Tainted Flesh
-- Note: Place holder for Hellion
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HELLION, 10, 7200) -- 2 hour minimum
end

return entity
