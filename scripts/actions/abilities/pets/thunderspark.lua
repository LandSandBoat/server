-----------------------------------
-- Thunderspark
-- Family: Ramuh (Player Pet)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage      = pet:getMainLvl() + 2
    params.fTP             = { 2.500, 3.000, 3.246 }
    params.int_wSC         = 0.30
    params.element         = xi.element.THUNDER
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.THUNDER
    params.shadowBehavior  = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    params.dStatMultiplier = 1.5
    params.canMagicBurst   = true
    params.primaryMessage  = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(pet, target, xi.effect.PARALYSIS, 15, 0, 60)
    end

    return info.damage
end

return abilityObject
