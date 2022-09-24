-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Cave Antlion
-----------------------------------
mixins = { require("scripts/mixins/families/antlion_ambush") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 0)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
