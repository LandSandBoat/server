-----------------------------------
-- Remove Curse
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")

-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(pet, target, skill, action)
    local effect
    if target:delStatusEffect(xi.effect.CURSE_I) then
        skill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
        effect = xi.effect.CURSE_I
    elseif target:delStatusEffect(xi.effect.DOOM) then
        skill:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
        effect = xi.effect.DOOM
    else
        skill:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    return effect
end

return abilityObject
