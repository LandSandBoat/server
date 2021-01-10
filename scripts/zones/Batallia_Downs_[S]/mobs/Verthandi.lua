-----------------------------------
-- Area: Batallia_Downs_[S]
--  Mob: Verthandi
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.VERTHANDI_ENSNARER)
end

return entity
