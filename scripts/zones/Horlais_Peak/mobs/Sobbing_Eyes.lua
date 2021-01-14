-----------------------------------
-- Area: Horlais Peak
--  Mob: Sobbing Eyes
-- BCNM: Under Observation
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.SLEEPRES, 75)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
