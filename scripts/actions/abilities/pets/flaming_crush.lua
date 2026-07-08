-----------------------------------
-- Flaming Crush
-- Family: Avatar (Ifrit)
-- Description: Deals a twofold hybrid Physical/Magical(Fire) attack to a single target.
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage         = pet:getWeaponDmg()
    params.numHits            = 2
    params.fTP                = { 6.0, 6.0, 6.0 }
    params.fTPSubsequentHits  = { 1.0, 1.0, 1.0 }
    params.str_wSC            = 0.20
    params.int_wSC            = 0.20
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.BLUNT
    params.hybridSkill        = true
    params.hybridSkillElement = xi.element.FIRE
    params.hybridAttackType   = xi.attackType.MAGICAL
    params.hybridDamageType   = xi.damageType.FIRE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    -- params.accuracyModifier   = { 0, 0, 0 } TODO: Capture accuracy
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    local totalDamage = 0

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        if info.damage > 0 then
            target:takeDamage(info.damage, pet, info.attackType, info.damageType)
            totalDamage = totalDamage + info.damage
        end

        if info.hybridDamage > 0 and target:getHP() > 0 then
            target:takeDamage(info.hybridDamage, pet, info.hybridAttackType, info.hybridDamageType)
            totalDamage = totalDamage + info.hybridDamage
        end
    end

    return totalDamage
end

return abilityObject
