-----------------------------------
-- Earthen Ward
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local amount = pet:getMainLvl() * 2 + 50
    if target:addStatusEffect(xi.effect.STONESKIN, amount, 0, 900, 0, 0, 3) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return abilityObject
