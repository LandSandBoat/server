-----------------------------------
-- Area: Qufim Island
--  Mob: Gigas's Leech
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
