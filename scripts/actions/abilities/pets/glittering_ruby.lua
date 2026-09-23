-----------------------------------
-- Glittering Ruby
-- Family: Avatar (Carbuncle)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    -- Randomly gives STR/DEX/VIT/AGI/INT/MND/CHR
    -- Can overwrite an existing Glittering Ruby stat bonus
    local effects =
    {
        xi.effect.STR_BOOST,
        xi.effect.DEX_BOOST,
        xi.effect.VIT_BOOST,
        xi.effect.AGI_BOOST,
        xi.effect.INT_BOOST,
        xi.effect.MND_BOOST,
        xi.effect.CHR_BOOST,
    }

    local effectId     = utils.randomEntry(effects)
    local effectPower  = 3 + math.floor(pet:getMainLvl() / 5)
    local baseDuration = 180
    local bonusTime    = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration     = baseDuration + bonusTime

    -- TODO: Ecliptic Growl does not overwrite this.
    -- This does not overwrite Ecliptic Growl.
    -- This can overwrite itself.
    -- Unknown how it interacts with STAT_DOWN effects.
    -- Unknown how it interacts with GAIN/BOOST spells.

    if target:addStatusEffect(effectId, { power = effectPower, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)

        return
    end

    return effectId
end

return abilityObject
