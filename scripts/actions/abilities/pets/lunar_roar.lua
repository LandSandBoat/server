-----------------------------------
-- Lunar Roar
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local effect = target:dispelStatusEffect()
    if effect == xi.effect.NONE then
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    else
        target:dispelStatusEffect()
        petskill:setMsg(xi.msg.basic.NONE)
    end

    return 0
end

return abilityObject
