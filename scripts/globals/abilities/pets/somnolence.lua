-----------------------------------
-- Somnolence
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local params = {}
    params.ftp000 = 2 params.ftp150 = 2.5    params.ftp300 = 2.75
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.element = xi.magic.ele.DARK
    params.includemab = true
    params.maccBonus = xi.summon.getSummoningSkillOverCap(pet)
    params.damageSpell = true

    local damage = xi.summon.avatarMagicSkill(pet, target, skill, params)

    local dINT = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    local effectParams = {}
    effectParams.dStat = dINT
    effectParams.element = xi.magic.ele.DARK
    effectParams.effect = xi.effect.WEIGHT
    effectParams.duration = 60
    effectParams.power = 46
    effectParams.tick = 0
    effectParams.maccBonus = 0

    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(totaldamage, pet, xi.attackType.MAGICAL, xi.damageType.DARK)

    if totaldamage > 0 then
        xi.magic.applyAbilityResistance(pet, target, effectParams)
    end

    xi.magic.handleSMNBurstMsg(pet, target, skill, params.element, xi.msg.basic.PET_MAGIC_BURST)

    return totaldamage
end

return abilityObject
