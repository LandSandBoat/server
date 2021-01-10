-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.OURYU_OVERWHELMER)
end

return entity
