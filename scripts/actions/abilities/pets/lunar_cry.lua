-----------------------------------
-- Lunar Cry
-- Family: Avatar (Fenrir)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local moonCycle = getVanadielMoonCycle()

    local cycleBuffs =
    {
        [xi.moonCycle.NEW_MOON]                = 1,
        [xi.moonCycle.LESSER_WAXING_CRESCENT]  = 6,
        [xi.moonCycle.GREATER_WAXING_CRESCENT] = 11,
        [xi.moonCycle.FIRST_QUARTER]           = 16,
        [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = 21,
        [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = 26,
        [xi.moonCycle.FULL_MOON]               = 31,
        [xi.moonCycle.GREATER_WANING_GIBBOUS]  = 26,
        [xi.moonCycle.LESSER_WANING_GIBBOUS]   = 21,
        [xi.moonCycle.THIRD_QUARTER]           = 16,
        [xi.moonCycle.GREATER_WANING_CRESCENT] = 11,
        [xi.moonCycle.LESSER_WANING_CRESCENT]  = 6,
    }

    local buffValue = cycleBuffs[moonCycle]

    -- TODO: Fenrir's Lunar Cry does not overwrite itself. Unknown interactions with other Accuracy Down/Evasion Down effects.

    local messageParams =
    {
        messageBypass          = false,
        messageCantGain        = xi.msg.basic.JA_NO_EFFECT,
        messageIsImmune        = xi.msg.basic.JA_MISS,
        messageIsTraitResisted = xi.msg.basic.JA_MISS,
        messageIsIncompatible  = xi.msg.basic.JA_MISS,
        messageIsResisted      = xi.msg.basic.JA_MISS,
        messageIsNotSuccessful = xi.msg.basic.JA_MISS,
        messageIsSuccessful    = xi.msg.basic.ACC_EVA_DOWN,
    }

    local baseDuration = 180 -- TODO: Capture retail baseDuration
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime

    local effectTable =
    {
        [1] = { effectId = xi.effect.ACCURACY_DOWN, power = buffValue, origin = pet, duration = duration, tier = 1, magicalElement = xi.element.DARK },
        [2] = { effectId = xi.effect.EVASION_DOWN, power = 32 - buffValue, origin = pet, duration = duration, tier = 1, magicalElement = xi.element.DARK },
    }

    return xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = false })
end

return abilityObject
