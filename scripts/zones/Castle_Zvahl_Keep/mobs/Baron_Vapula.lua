-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Baron Vapula
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/roe")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.HELLSBANE)
    xi.hunts.checkHunt(mob, player, 354)
    xi.roe.onRecordTrigger(player, 301)
end

return entity
