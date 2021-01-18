-----------------------------------
-- Remove Poison
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(pet, target, skill, action)
    if (target:delStatusEffect(tpz.effect.POISON)) then
        skill:setMsg(tpz.msg.basic.JA_REMOVE_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.JA_NO_EFFECT)
    end
    return tpz.effect.POISON
end

return ability_object
