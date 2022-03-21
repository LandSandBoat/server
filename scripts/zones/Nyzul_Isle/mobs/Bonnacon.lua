-----------------------------------
--  MOB: Bonnacon
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
require("scripts/globals/additional_effects")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMobMod(xi.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob,target,damage)
    return effectUtil.mobOnAddEffect(mob, target, damage, effectUtil.mobAdditionalEffect.STUN, {chance = 50, duration = math.random(4, 8)})
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
