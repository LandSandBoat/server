-----------------------------------
-- Wind Blade
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill)
    local params = {}
    params.ftp000 = 5.375 params.ftp150 = 8 params.ftp300 = 10.7
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.element = xi.magic.ele.WIND
    params.includemab = true
    params.maccBonus = xi.summon.getSummoningSkillOverCap(pet)
    params.damageSpell = true

    local damage = xi.summon.avatarMagicSkill(pet, target, skill, params)

    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(totaldamage, pet, xi.attackType.MAGICAL, xi.damageType.WIND)

    xi.magic.handleSMNBurstMsg(pet, target, skill, params.element, xi.msg.basic.PET_MAGIC_BURST)

    return totaldamage
end

return abilityObject
