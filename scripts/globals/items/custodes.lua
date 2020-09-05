-----------------------------------------
-- ID: 18762
-- Item: Custodes
-- Additional Effect: Paralysis
-----------------------------------------
require("scripts/globals/weather")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 5

    if (VanadielDayElement() == tpz.day.ICEDAY) then
        chance = chance+6
    end

    if (player:getWeather() == WEATHER_ICE) then
        chance = chance+4
    elseif (player:getWeather() == tpz.weather.BLIZZARDS) then
        chance = chance+6
    end

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(tpz.effect.PARALYSIS, 5, 0, 30)
        return tpz.subEffect.PARALYSIS, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.PARALYSIS
    end
end
