-----------------------------------
-- Raise II
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if not target:isPC() or target:isAlive() then
        petskill:setMsg(xi.msg.basic.NO_EFFECT)
        return 0
    end

    petskill:setMsg(xi.msg.basic.NONE)
    target:sendRaise(2)
    return 0
end

return abilityObject
