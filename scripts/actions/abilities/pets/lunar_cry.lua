-----------------------------------
-- Lunar Cry
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

    target:delStatusEffect(xi.effect.ACCURACY_DOWN)
    target:delStatusEffect(xi.effect.EVASION_DOWN)
    target:addStatusEffect(xi.effect.ACCURACY_DOWN, buffValue, 0, 180)
    target:addStatusEffect(xi.effect.EVASION_DOWN, 32-buffValue, 0, 180)

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.ACC_EVA_DOWN)
    end

    return 0
end

return abilityObject
