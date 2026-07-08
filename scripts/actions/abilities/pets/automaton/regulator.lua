-----------------------------------
-- Regulator
-- https://wiki.ffo.jp/html/33541.html
-- Absorbs one beneficial effect from the target.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60)

    local absorbedEffect = automaton:stealStatusEffect(target, xi.effectFlag.DISPELABLE)

    if absorbedEffect ~= 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
        return 1
    else
        skill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return 0
    end
end

return abilityObject
