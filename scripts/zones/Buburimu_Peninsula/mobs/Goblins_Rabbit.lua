-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Goblin's Rabbit
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
