-----------------------------------
-- ID: 18762
-- Item: Custodes
-- Additional Effect: Paralysis
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 5

    if (VanadielDayOfTheWeek() == xi.day.ICEDAY) then
        chance = chance+6
    end

    if (player:getWeather() == WEATHER_ICE) then
        chance = chance+4
    elseif (player:getWeather() == xi.weather.BLIZZARDS) then
        chance = chance+6
    end

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.ICE, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(xi.effect.PARALYSIS, 5, 0, 30)
        return xi.subEffect.PARALYSIS, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.PARALYSIS
    end
end

return item_object
