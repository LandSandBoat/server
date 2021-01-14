-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Viscount Morax
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 356)
    player:addTitle(tpz.title.HELLSBANE)
end

return entity
