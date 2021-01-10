-----------------------------------
-- Area: Jugner_Forest_[S]
--  Mob: Dark Ixion
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.IXION_HORNBREAKER)
end

return entity
