-----------------------------------
-- Ecliptic Growl
-- Family: Avatar (Fenrir)
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

    local moonCycle = getVanadielMoonCycle()

    local cycleBuffs =
    {
        [xi.moonCycle.NEW_MOON]                = 1,
        [xi.moonCycle.LESSER_WAXING_CRESCENT]  = 2,
        [xi.moonCycle.GREATER_WAXING_CRESCENT] = 3,
        [xi.moonCycle.FIRST_QUARTER]           = 4,
        [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = 5,
        [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = 6,
        [xi.moonCycle.FULL_MOON]               = 7,
        [xi.moonCycle.GREATER_WANING_GIBBOUS]  = 6,
        [xi.moonCycle.LESSER_WANING_GIBBOUS]   = 5,
        [xi.moonCycle.THIRD_QUARTER]           = 4,
        [xi.moonCycle.GREATER_WANING_CRESCENT] = 3,
        [xi.moonCycle.LESSER_WANING_CRESCENT]  = 2,
    }

    local buffValue = cycleBuffs[moonCycle]

    -- TODO: Glittering Ruby does not overwrite this.
    -- This does not overwrite Glittering Ruby.
    -- This can overwrite itself.
    -- Unknown how it interacts with STAT_DOWN effects.
    -- Unknown how it interacts with GAIN/BOOST spells.

    target:addStatusEffect(xi.effect.STR_BOOST, { power = buffValue, duration = duration, origin = pet })
    target:addStatusEffect(xi.effect.DEX_BOOST, { power = buffValue, duration = duration, origin = pet })
    target:addStatusEffect(xi.effect.VIT_BOOST, { power = buffValue, duration = duration, origin = pet })
    target:addStatusEffect(xi.effect.AGI_BOOST, { power = 8-buffValue, duration = duration, origin = pet })
    target:addStatusEffect(xi.effect.INT_BOOST, { power = 8-buffValue, duration = duration, origin = pet })
    target:addStatusEffect(xi.effect.MND_BOOST, { power = 8-buffValue, duration = duration, origin = pet })
    target:addStatusEffect(xi.effect.CHR_BOOST, { power = 8-buffValue, duration = duration, origin = pet })

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.STATUS_BOOST)
    else
        petskill:setMsg(xi.msg.basic.STATUS_BOOST_2)
    end

    return 0
end

return abilityObject
