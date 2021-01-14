-----------------------------------
-- Area: Horlais Peak
--  Mob: Dread Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.DREAD_DRAGON_SLAYER)
end

return entity
