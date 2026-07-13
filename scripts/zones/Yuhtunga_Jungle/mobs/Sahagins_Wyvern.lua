-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Sahagin's Wyvern
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.expeditionaryForce.gatePet(mob)
end

return entity
