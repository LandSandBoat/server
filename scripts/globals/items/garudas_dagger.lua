-----------------------------------
-- ID: 17627
-- Item: Garuda's Dagger
-- Additional Effect: Silence
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if (VanadielDayOfTheWeek() == xi.day.WINDSDAY) then
        chance = chance+6
    end

    if (player:getWeather() == xi.weather.WIND) then
        chance = chance+4
    elseif (player:getWeather() == xi.weather.GALES) then
        chance = chance+6
    end

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.WIND, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(xi.effect.SILENCE, 10, 0, 30)
        return xi.subEffect.SILENCE, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.SILENCE
    end
end

return item_object
