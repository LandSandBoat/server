-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Goblin's Bee
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
