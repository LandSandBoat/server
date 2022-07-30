-----------------------------------
-- Area: Ifrits Cauldron
--   NM: Tarasque
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 35, 0, 0)
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setFlag(xi.effectFlag.DEATH)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 403)
end

return entity
