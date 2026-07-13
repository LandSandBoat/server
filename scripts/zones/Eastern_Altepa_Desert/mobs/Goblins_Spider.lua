-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Goblin's Spider
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
