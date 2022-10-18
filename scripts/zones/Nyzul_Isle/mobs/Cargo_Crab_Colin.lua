-----------------------------------
--  MOB: Cargo Crab Colin
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require('scripts/globals/nyzul')
require('scripts/globals/status')
require('scripts/globals/additional_effects')
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    -- mob:addImmunity(xi.immunity.SLEEP)
    -- mob:addImmunity(xi.immunity.BIND)
    -- mob:addImmunity(xi.immunity.POISON)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- poison tick and duration unverified
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 40, tick = 3, duration = 15 })
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.eliminateAllKill(mob)
    end
end

return entity
