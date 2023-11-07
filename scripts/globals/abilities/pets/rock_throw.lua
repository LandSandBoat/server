-----------------------------------
-- Rock Throw
-----------------------------------
require("scripts/globals/summon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local params = {}
    params.numHits = 1
    params.ftp000 = 1 params.ftp150 = 1 params.ftp300 = 1
    params.str_wsc = 0.2 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.2 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.acc100 = 1.0 params.acc200 = 1.0 params.acc300 = 1.0
    params.atk100 = 1.0 params.atk200 = 1.0 params.atk300 = 1.0
    params.melee = false

    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, params)

    local dMND = pet:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    local effectParams = {}
    effectParams.dStat = dMND
    effectParams.element = xi.magic.ele.EARTH
    effectParams.effect = xi.effect.SLOW
    effectParams.duration = 120
    effectParams.power = 3000
    effectParams.tick = 0
    effectParams.maccBonus = 0

    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, damage.hitslanded)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    if totaldamage > 0 then
        xi.magic.applyAbilityResistance(pet, target, effectParams)
    end

    return totaldamage
end

return abilityObject
