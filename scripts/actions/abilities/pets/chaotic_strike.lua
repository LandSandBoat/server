-----------------------------------
-- Chaotic Strike
-- Family: Avatar (Ramuh)
-- Description: Delivers a threefold attack that deals Physical damage to a target. Additional Effect: Stun
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
    params.numHits           = 3
    params.fTP               = { 10.00, 10.00, 10.00 }
    params.fTPSubsequentHits = { 10.00, 10.00, 10.00 }
    params.str_wSC           = 0.20
    params.int_wSC           = 0.20
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    params.canCrit           = true
    params.criticalChance    = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.STUN, power = 1, duration = 12, origin = pet },
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return abilityObject
