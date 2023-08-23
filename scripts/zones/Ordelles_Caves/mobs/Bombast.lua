-----------------------------------
-- Area: Ordelles Caves
--   NM: Bombast
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- TODO: Revisit spikes damage for this NM after duplicate spikes issue is resolved with onSpikesDamage
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 15, 0, 0)
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 182)
end

return entity
