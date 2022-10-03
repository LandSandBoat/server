-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Count Bifrons
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 355)
    player:addTitle(xi.title.HELLSBANE)
end

return entity
