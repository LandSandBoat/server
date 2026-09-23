-----------------------------------
-- Somnolence
-- Family: Avatar (Diabolos)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage     = pet:getMainLvl() + 2
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    params.canMagicBurst  = true
    params.primaryMessage = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobMagicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local duration = 120 -- TODO: Capture retail baseDuration.

        local effectTable =
        {
            -- TODO: Is effect element Wind or Dark?
            [1] = { effectId = xi.effect.WEIGHT, power = 50, duration = duration, magicalElement = xi.element.WIND },
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return abilityObject
