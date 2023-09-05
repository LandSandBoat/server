-----------------------------------
-- Aerial Armor
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local duration = 180
    local moon = VanadielMoonPhase()
    local buffvalue = 0
    if moon > 90 then
        buffvalue = 25
    elseif moon > 75 then
        buffvalue = 21
    elseif moon > 60 then
        buffvalue = 17
    elseif moon > 40 then
        buffvalue = 13
    elseif moon > 25 then
        buffvalue = 9
    elseif moon > 10 then
        buffvalue = 5
    else
        buffvalue = 1
    end

    target:delStatusEffect(xi.effect.ACCURACY_BOOST)
    target:delStatusEffect(xi.effect.EVASION_BOOST)
    target:addStatusEffect(xi.effect.ACCURACY_BOOST, buffvalue, 0, duration)
    target:addStatusEffect(xi.effect.EVASION_BOOST, 25-buffvalue, 0, duration)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return abilityObject
