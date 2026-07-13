-----------------------------------
-- Area: Qufim Island
--  Mob: Goblin's Leech
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
