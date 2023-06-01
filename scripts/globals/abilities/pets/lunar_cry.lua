-----------------------------------
-- Aerial Armor
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local moon = VanadielMoonPhase()
    local buffvalue = 0
    if moon > 90 then
        buffvalue = 31
    elseif moon > 75 then
        buffvalue = 26
    elseif moon > 60 then
        buffvalue = 21
    elseif moon > 40 then
        buffvalue = 16
    elseif moon > 25 then
        buffvalue = 11
    elseif moon > 10 then
        buffvalue = 6
    else
        buffvalue = 1
    end

    target:delStatusEffect(xi.effect.ACCURACY_DOWN)
    target:delStatusEffect(xi.effect.EVASION_DOWN)
    target:addStatusEffect(xi.effect.ACCURACY_DOWN, buffvalue, 0, 180)
    target:addStatusEffect(xi.effect.EVASION_DOWN, 32-buffvalue, 0, 180)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return abilityObject
