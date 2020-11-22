-----------------------------------------
-- ID: 17627
-- Item: Garuda's Dagger
-- Additional Effect: Silence
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10

    if (VanadielDayOfTheWeek() == tpz.day.WINDSDAY) then
        chance = chance+6
    end

    if (player:getWeather() == tpz.weather.WIND) then
        chance = chance+4
    elseif (player:getWeather() == tpz.weather.GALES) then
        chance = chance+6
    end

    if (math.random(0, 99) >= chance or applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 0) <= 0.5) then
        return 0, 0, 0
    else
        target:addStatusEffect(tpz.effect.SILENCE, 10, 0, 30)
        return tpz.subEffect.SILENCE, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.SILENCE
    end
end
