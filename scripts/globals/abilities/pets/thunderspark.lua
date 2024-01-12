-----------------------------------
-- Thunderspark M=whatever
-----------------------------------
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
    params.ftp000 = 2.5 params.ftp150 = 3 params.ftp300 = 3.25
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.element = xi.magic.ele.LIGHTNING
    params.includemab = true
    params.maccBonus = xi.summon.getSummoningSkillOverCap(pet)
    params.damageSpell = true

    local damage = xi.summon.avatarMagicSkill(pet, target, skill, params)

    local dMND = pet:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)

    local effectParams = {}
    effectParams.dStat = dMND
    effectParams.element = xi.magic.ele.ICE
    effectParams.effect = xi.effect.PARALYSIS
    effectParams.duration = 60
    effectParams.power = 23
    effectParams.tick = 0
    effectParams.maccBonus = 0

    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(totaldamage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)

    if totaldamage > 0 then
        xi.magic.applyAbilityResistance(pet, target, effectParams)
    end

    xi.magic.handleSMNBurstMsg(pet, target, skill, params.element, xi.msg.basic.PET_MAGIC_BURST)

    return totaldamage
end

return abilityObject
