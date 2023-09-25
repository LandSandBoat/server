-----------------------------------
-- Shining Ruby
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    target:delStatusEffect(xi.effect.SHINING_RUBY)
    target:addStatusEffect(xi.effect.SHINING_RUBY, 1, 0, 180)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.SHINING_RUBY
end

return abilityObject
