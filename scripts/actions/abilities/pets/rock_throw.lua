-----------------------------------
-- Rock Throw
-- Family: Avatar (Titan)
-- Description: Delivers a ranged attack to a target. Additional Effect: Slow
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getRangedDmg()
    params.numHits           = 1
    params.fTP               = { 1.0, 1.0, 1.0 }
    params.fTPSubsequentHits = { 1.0, 1.0, 1.0 }
    params.str_wSC           = 0.20
    params.agi_wSC           = 0.20
    params.skipParry         = true
    params.skipGuard         = true
    params.skipBlock         = true
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    -- params.accuracyModifier   = { 0, 0, 0 } TODO: Capture accuracy
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobRangedMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW, power = 3000, duration = 120, tier = 8, origin = pet }, -- TODO: Capture Slow tier
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return abilityObject
