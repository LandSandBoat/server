-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Baron Vapula
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 354)
    player:addTitle(xi.title.HELLSBANE)
end

return entity
