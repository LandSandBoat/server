-----------------------------------
-- Area: Fei'Yin
--   NM: Goliath
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.GOLIATH_KILLER)
end

return entity
