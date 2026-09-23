-----------------------------------
-- Slowga
-- Family: Avatar (Leviathan)
-- Note: Ability range was increased in Sept. 6, 2016 update.
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local baseDuration = 180
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime

    local effectTable =
    {
        [1] = { effectId = xi.effect.SLOW, power = 3000, origin = pet, duration = duration, tier = 3, magicalElement = xi.element.EARTH, bonusMacc = xi.summon.getSummoningSkillOverCap(pet) },
    }

    local messageParams =
    {
        messageBypass          = false,
        messageCantGain        = xi.msg.basic.JA_NO_EFFECT,
        messageIsImmune        = xi.msg.basic.JA_MISS,
        messageIsTraitResisted = xi.msg.basic.JA_MISS,
        messageIsIncompatible  = xi.msg.basic.JA_MISS,
        messageIsResisted      = xi.msg.basic.JA_MISS,
        messageIsNotSuccessful = xi.msg.basic.JA_MISS,
        messageIsSuccessful    = xi.msg.basic.JA_ENFEEB_IS,
    }

    return xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, messageParams)
end

return abilityObject
