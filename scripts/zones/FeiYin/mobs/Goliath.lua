-----------------------------------
-- Area: Fei'Yin
--   NM: Goliath
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.GOLIATH_KILLER)
end

return entity
