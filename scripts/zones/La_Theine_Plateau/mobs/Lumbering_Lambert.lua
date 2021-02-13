-----------------------------------
-- Area: La Theine Plateau
--  Mob: Lumbering Lambert
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 156)
    tpz.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BLOODTEAR_PH, 10, math.random(75600, 86400)) -- 21-24 hours
end

return entity
