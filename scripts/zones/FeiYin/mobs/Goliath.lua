-----------------------------------
-- Area: Fei'Yin
--   NM: Goliath
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.GOLIATH_KILLER)
end

return entity
