-----------------------------------
-- Barracude Dive
-- Family: Avatar (Leviathan)
-- Description: Deals Physical damage to a single target.
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
    params.numHits           = 1
    params.fTP               = { 2.0, 2.0, 2.0 }
    params.fTPSubsequentHits = { 2.0, 2.0, 2.0 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    -- params.accuracyModifier   = { 0, 0, 0 } -- TODO: JP Wiki/Patch notes state this has an accuracy modifier.
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
