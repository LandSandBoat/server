-----------------------------------
-- Healing Ruby
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    -- TODO: verify retail fomula
    local base = 14 + target:getMainLvl() + pet:getTP() / 12

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if pet:getMainLvl() > 30 then
        base = 44 + 3 * (pet:getMainLvl() - 30) + pet:getTP() / 12 * (pet:getMainLvl() * 0.075 - 1)
    end

    if target:getHP() + base > target:getMaxHP() then
        base = target:getMaxHP() - target:getHP() --cap it
    end

    petskill:setMsg(xi.msg.basic.JA_RECOVERS_HP_2)
    target:addHP(base)
    return base
end

return abilityObject
