-----------------------------------
-- Whispering Wind
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local base = 16 + pet:getMainLvl() * 2.5

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
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
