-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Goblin's Dragonfly
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
