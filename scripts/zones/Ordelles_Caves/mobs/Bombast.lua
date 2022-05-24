-----------------------------------
-- Area: Ordelles Caves
--   NM: Bombast
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 15, 0, 0)
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setFlag(xi.effectFlag.DEATH)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 182)
end

return entity
