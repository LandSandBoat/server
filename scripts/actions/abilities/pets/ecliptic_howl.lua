-----------------------------------
-- Ecliptic Howl
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local bonusTime = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 180 + bonusTime

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local moonCycle = getVanadielMoonCycle()

    local cycleBuffs =
    {
        [xi.moonCycle.NEW_MOON]                = 1,
        [xi.moonCycle.LESSER_WAXING_CRESCENT]  = 5,
        [xi.moonCycle.GREATER_WAXING_CRESCENT] = 9,
        [xi.moonCycle.FIRST_QUARTER]           = 13,
        [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = 17,
        [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = 21,
        [xi.moonCycle.FULL_MOON]               = 25,
        [xi.moonCycle.GREATER_WANING_GIBBOUS]  = 21,
        [xi.moonCycle.LESSER_WANING_GIBBOUS]   = 17,
        [xi.moonCycle.THIRD_QUARTER]           = 13,
        [xi.moonCycle.GREATER_WANING_CRESCENT] = 9,
        [xi.moonCycle.LESSER_WANING_CRESCENT]  = 5,
    }

    local buffValue = cycleBuffs[moonCycle]

    target:delStatusEffect(xi.effect.ACCURACY_BOOST)
    target:delStatusEffect(xi.effect.EVASION_BOOST)
    target:addStatusEffect(xi.effect.ACCURACY_BOOST, buffValue, 0, duration)
    target:addStatusEffect(xi.effect.EVASION_BOOST, 25-buffValue, 0, duration)

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.ACC_EVA_BOOST)
    else
        petskill:setMsg(xi.msg.basic.ACC_EVA_BOOST_2)
    end

    return 0
end

return abilityObject
