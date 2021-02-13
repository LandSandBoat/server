-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Habetrot
-- !pos -60 -8 58 220
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 386)
end

return entity
