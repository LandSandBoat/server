-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Mindertaur
--  ENM: Brothers
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SILENCERES, 75)
    mob:setMod(xi.mod.DMGMAGIC, -1000)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
