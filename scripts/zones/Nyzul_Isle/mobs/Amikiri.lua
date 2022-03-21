-----------------------------------
--  MOB: Amikiri
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
require("scripts/globals/additional_effects")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT,1)
    mob:addImmunity(xi.immunity.SLEEP)
end

function onAdditionalEffect(mob, player)
    return effectUtil.mobOnAddEffect(mob, player, damage, effectUtil.mobAdditionalEffect.POISON, {chance = 40, tick = 50, duration = 15})
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
