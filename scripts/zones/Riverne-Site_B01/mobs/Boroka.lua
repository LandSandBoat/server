-----------------------------------
-- Area: Riverne - Site B01
--   NM: Boroka
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BOROKA_BELEAGUERER)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21-24 hour respawn
end

return entity
