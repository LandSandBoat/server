-----------------------------------
--  MOB: Bloodsucker
-- Area: Nyzul Isle
-- Info: NM
-----------------------------------
require("scripts/globals/utils/nyzul")
require("scripts/globals/additional_effects")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, player)
    return effectUtil.mobOnAddEffect(mob, player, damage, effectUtil.mobAdditionalEffect.HP_DRAIN, {power = math.random(40,180), chance = 20})
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.eliminateAllKill(mob)
    end
end
