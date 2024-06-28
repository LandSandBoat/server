-----------------------------------
-- Eerie Eye
-- silence + amnesia
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)
    local returnEffect = xi.effect.NONE
    local duration = 30
    local ele = xi.element.LIGHT
    local bonus = pet:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR) - 10
    if summoner ~= nil and summoner:isPC() then
        bonus = bonus + xi.summon.getSummoningSkillOverCap(pet)
    end

    local resist = applyResistanceAbility(pet, target, ele, xi.skill.ENFEEBLING_MAGIC, bonus)

    -- https://wikiwiki.jp/ffxi/%E5%8F%AC%E5%96%9A%E9%AD%94%E6%B3%95
    -- TL;DR base 30s silence and 10s amnesia (also amnesia is fire element)
    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(xi.effect.SILENCE, 1, 0, duration * resist) then
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            local resist2 = applyResistanceAbility(pet, target, xi.element.FIRE, xi.skill.ENFEEBLING_MAGIC, bonus)
            if
                resist2 >= 0.5 and
                target:addStatusEffect(xi.effect.AMNESIA, 1, 0, duration * resist2 / 3)
            then
                returnEffect = xi.effect.AMNESIA
            else
                returnEffect = xi.effect.SILENCE
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    return returnEffect
end

return abilityObject
