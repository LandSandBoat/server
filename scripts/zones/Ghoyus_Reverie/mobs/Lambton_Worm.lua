-----------------------------------
-- Area: Ghoyu's Reverie
--  Mob: Lambton Worm
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.LAMBTON_WORM_DESEGMENTER)
end

return entity
