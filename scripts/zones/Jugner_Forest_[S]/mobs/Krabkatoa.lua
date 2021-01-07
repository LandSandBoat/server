-----------------------------------
-- Area: Jugner_Forest_[S]
--  Mob: Krabkatoa
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.KRABKATOA_STEAMER)
end

return entity
