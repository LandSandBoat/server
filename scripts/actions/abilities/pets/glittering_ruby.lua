-----------------------------------
-- Glittering Ruby
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    --randomly give str/dex/vit/agi/int/mnd/chr (+12)
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

    local effectId    = utils.randomEntry(effects)
    local effectPower = 3 + math.floor(pet:getMainLvl() / 5)

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    target:addStatusEffect(effectId, effectPower, 0, 90)

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    end

    return effectId
end

return abilityObject
