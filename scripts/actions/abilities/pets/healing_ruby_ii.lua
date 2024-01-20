-----------------------------------
-- Healing Ruby II
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local base = 28 + pet:getMainLvl() * 4

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    petskill:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
    target:addHP(base)
    return base
end

return abilityObject
