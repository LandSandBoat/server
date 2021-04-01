-----------------------------------
-- Area: Jugner_Forest_[S]
--  Mob: Krabkatoa
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.KRABKATOA_STEAMER)
end

return entity
