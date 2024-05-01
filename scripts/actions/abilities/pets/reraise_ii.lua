-----------------------------------
-- Reraise II
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if
        not target:isPC() or
        not target:addStatusEffect(xi.effect.RERAISE, 2, 0, 3600)
    then
        petskill:setMsg(xi.msg.basic.NO_EFFECT)
        return 0
    end

    petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    return xi.effect.RERAISE
end

return abilityObject
