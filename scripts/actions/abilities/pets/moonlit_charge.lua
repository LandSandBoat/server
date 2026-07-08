-----------------------------------
-- Moonlit Charge
-- Family: Avatar (Fenrir)
-- Description: Delivers a physical Blunt attack to a target. Additional Effect: Blind
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
    params.fTP               = { 1.0, 1.0, 1.0 }
    params.fTPSubsequentHits = { 1.0, 1.0, 1.0 }
    params.vit_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    -- params.accuracyModifier   = { 0, 0, 0 } TODO: Capture accuracy
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.BLINDNESS, power = 25, duration = 60, origin = pet },
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return abilityObject
