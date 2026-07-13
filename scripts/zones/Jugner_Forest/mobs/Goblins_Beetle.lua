-----------------------------------
-- Area: Jugner Forest
--  Mob: Goblin's Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
