-----------------------------------
-- Area: La Theine Plateau
--  Mob: Battering Ram
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    if not xi.mob.phOnDespawn(mob, ID.mob.BLOODTEAR_PH, 10, math.random(75600, 86400)) then -- 21-24 hours
        xi.mob.phOnDespawn(mob, ID.mob.LUMBERING_LAMBERT_PH, 10, 1200) -- 20 min
    end
end

return entity
