---------------------------------------------
-- Remove Disease
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")

---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(pet, target, skill, action)
    local effect
    if (target:delStatusEffect(tpz.effect.DISEASE)) then
        skill:setMsg(tpz.msg.basic.JA_REMOVE_EFFECT)
        effect = tpz.effect.DISEASE
    elseif (target:delStatusEffect(tpz.effect.PLAGUE)) then
        skill:setMsg(tpz.msg.basic.JA_REMOVE_EFFECT)
        effect = tpz.effect.PLAGUE
    else
        skill:setMsg(tpz.msg.basic.JA_NO_EFFECT)
    end

    return effect
end
