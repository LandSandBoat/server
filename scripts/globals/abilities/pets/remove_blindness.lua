---------------------------------------------
-- Remove Blindness
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(pet, target, skill, action)
    if (target:delStatusEffect(tpz.effect.BLINDNESS)) then
        skill:setMsg(tpz.msg.basic.JA_REMOVE_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.JA_NO_EFFECT)
    end
    return tpz.effect.BLINDNESS
end

return ability_object
