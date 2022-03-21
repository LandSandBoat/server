-----------------------------------
--  MOB: Hellion
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
require("scripts/globals/additional_effects")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT,1)
end

function onAdditionalEffect(mob, player)
    return effectUtil.mobOnAddEffect(mob, player, math.random(40,95), effectUtil.mobAdditionalEffect.ENDARK, {chance = 80})
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
