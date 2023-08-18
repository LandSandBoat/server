-----------------------------------
-- Area: Konschtat Highlands
--   NM: Rampaging Ram
-----------------------------------
require("scripts/globals/hunts")
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 205)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.STEELFLEECE_PH, 10, 75600) -- 21 hours minimum
end

return entity
