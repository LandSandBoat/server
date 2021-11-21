-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Lich C Magnus
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.LICH_BANISHER)
end

return entity
