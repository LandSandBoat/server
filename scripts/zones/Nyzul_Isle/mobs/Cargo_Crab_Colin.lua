-----------------------------------
--  MOB: Cargo Crab Colin
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
require("scripts/globals/status")
require("scripts/globals/additional_effects")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.SLEEP)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.POISON)
end

function onAdditionalEffect(mob, player)
    -- poison tick and duration unverified
    return effectUtil.mobOnAddEffect(mob, player, damage, effectUtil.mobAdditionalEffect.POISON, {chance = 40, tick = 3, duration = 15})
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
