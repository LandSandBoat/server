-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Mindertaur
--  ENM: Brothers
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.SILENCERES, 75)
    mob:setMod(tpz.mod.DMGMAGIC, -10)
    mob:setMod(tpz.mod.SLEEPRES, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
