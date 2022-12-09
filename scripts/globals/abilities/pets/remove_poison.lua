-----------------------------------
-- Remove Poison
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")

-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(pet, target, skill, action)
    if target:delStatusEffect(xi.effect.POISON) then
        skill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
    else
        skill:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    return xi.effect.POISON
end

return abilityObject
