-----------------------------------
-- Spring Water
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local base = 47 + pet:getMainLvl() * 3
    local tp   = pet:getTP()

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if tp < 1000 then
        tp = 1000
    end

    base = base * tp / 1000

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    target:delStatusEffect(xi.effect.BLINDNESS)
    target:delStatusEffect(xi.effect.POISON)
    target:delStatusEffect(xi.effect.PARALYSIS)
    target:delStatusEffect(xi.effect.DISEASE)
    target:delStatusEffect(xi.effect.PETRIFICATION)
    target:wakeUp()
    target:delStatusEffect(xi.effect.SILENCE)

    if math.random() > 0.5 then
        target:delStatusEffect(xi.effect.SLOW)
    end

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.JA_RECOVERS_HP_2)
    else
        petskill:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
    end

    target:addHP(base)
    return base
end

return abilityObject
