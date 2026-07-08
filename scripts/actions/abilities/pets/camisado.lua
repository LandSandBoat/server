-----------------------------------
-- Camisado
-- Family: Avatar (Diabolos)
-- Description: Deals Physical damage to a target. Additional Effect: Knockback
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
    params.str_wSC           = 0.20
    params.mnd_wSC           = 0.20
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    -- params.accuracyModifier    = { 0, 0, 0 } TODO: Capture accuracy
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        -- TODO: Knockback may not yet be hooked up to abilities.
        -- action:knockback(target:getID(), xi.action.knockback.LEVEL3)

        -- TODO: Some equipment that reduces movement speed can reduce knockback distance. (Example: Plumb Boots)
        -- https://discord.com/channels/392903136336936960/883227978002206751/1280243231635804262
        -- https://discord.com/channels/443544205206355968/443893540922064896/1376405495845355661
    end

    return info.damage
end

return abilityObject
