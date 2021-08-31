-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Eldertaur
--  ENM: Brothers
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.DMGMAGIC, -1000)
    mob:setMod(xi.mod.SLEEPRES, 75)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
