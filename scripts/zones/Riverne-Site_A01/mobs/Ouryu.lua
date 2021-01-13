-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.OURYU_OVERWHELMER)
end

return entity
