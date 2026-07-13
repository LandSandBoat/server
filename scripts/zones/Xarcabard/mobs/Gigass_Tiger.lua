-----------------------------------
-- Area: Xarcabard
--  Mob: Gigas's Tiger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
