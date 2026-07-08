-----------------------------------
-- Double Slap
-- Family: Avatar (Shiva)
-- Description: Delivers a two fold attack to a target.
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 2
    params.fTP               = { 6.328125, 6.328125, 6.328125 }
    params.fTPSubsequentHits = { 6.328125, 6.328125, 6.328125 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    -- params.accuracyModifier   = { 0, 0, 0 } TODO: Capture accuracy
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
