-----------------------------------
-- Flaming Crush
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill)
    local params = {}
    params.numHits = 2
    params.ftp000 = 7 params.ftp150 = 7 params.ftp300 = 7
    params.str_wsc = 0.2 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.2 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.acc100 = 1.0 params.acc200 = 1.0 params.acc300 = 1.0
    params.atk100 = 1.0 params.atk200 = 1.0 params.atk300 = 1.0
    params.melee = true

    local paramsEle = {}
    paramsEle.ftp000 = 6 paramsEle.ftp150 = 6 paramsEle.ftp300 = 6
    paramsEle.str_wsc = 0.2 paramsEle.dex_wsc = 0.0 paramsEle.vit_wsc = 0.0 paramsEle.agi_wsc = 0.0 paramsEle.int_wsc = 0.2 paramsEle.mnd_wsc = 0.0 paramsEle.chr_wsc = 0.0
    paramsEle.element = xi.magic.ele.FIRE
    paramsEle.includemab = true
    paramsEle.maccBonus = xi.summon.getSummoningSkillOverCap(pet)
    paramsEle.ignoreStateLock = true

    -- Do physical damage
    local damagePhys = xi.summon.avatarPhysicalMove(pet, target, skill, params)
    -- Do magical damage
    local damageEle = xi.summon.avatarMagicSkill(pet, target, skill, paramsEle)

    local totaldamagePhys = xi.summon.avatarFinalAdjustments(damagePhys.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, damagePhys.hitslanded)
    local totaldamageEle = xi.summon.avatarFinalAdjustments(damageEle.dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(totaldamagePhys, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:takeDamage(totaldamageEle, pet, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return totaldamagePhys + totaldamageEle
end

return abilityObject
