-----------------------------------
-- Area: Fei'Yin
--   NM: Goliath
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.GOLIATH_KILLER)
end

return entity
