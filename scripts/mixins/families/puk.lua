-- Puk family mixin
require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/world")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.puk = function(mob)
    mob:addListener("SPAWN", "PUK_SPAWN", function(puk)
        puk:setMod(xi.mod.WIND_ABSORB, 100)
    end)

    mob:addListener("TAKE_DAMAGE", "PUK_TAKE_DAMAGE", function(puk, amount, attacker, attackType, damageType)
        local elements =
        {
            { xi.damageType.FIRE,      xi.day.FIRESDAY },
            { xi.damageType.EARTH,     xi.day.EARTHSDAY },
            { xi.damageType.WATER,     xi.day.WATERSDAY },
            { xi.damageType.WIND,      xi.day.WINDSDAY },
            { xi.damageType.ICE,       xi.day.ICEDAY },
            { xi.damageType.LIGHTNING, xi.day.LIGHTNINGSDAY },
            { xi.damageType.LIGHT,     xi.day.LIGHTSDAY },
            { xi.damageType.DARK,      xi.day.DARKSDAY }
        }

        -- If the element corresponding to the elemental day of the in-game Vana'diel week is used on a Puk, it will get 100% TP instantly.
        for k, v in pairs(elements) do
            if damageType == v[1] and VanadielDayOfTheWeek() == v[2] then
                puk:addTP(3000)
            end
        end
    end)

    mob:addListener("ROAM_TICK", "PUK_ROAM_TICK", function(puk)
        if
            (VanadielDayOfTheWeek() == xi.day.WINDSDAY or
            puk:getWeather() == xi.weather.WIND or
            puk:getWeather() == xi.weather.GALES) and
            puk:getMod(xi.mod.REGAIN) == 0
        then
            puk:setMod(xi.mod.REGAIN, 30)
        elseif
            VanadielDayOfTheWeek() ~= xi.day.WINDSDAY and
            puk:getWeather() == xi.weather.WIND and
            puk:getWeather() == xi.weather.GALES and
            puk:getMod(xi.mod.REGAIN) ~= 0
        then
            puk:setMod(xi.mod.REGAIN, 0)
        end
    end)

    mob:addListener("COMBAT_TICK", "PUK_COMBAT_TICK", function(puk)
        if
            (VanadielDayOfTheWeek() == xi.day.WINDSDAY or
            puk:getWeather() == xi.weather.WIND or
            puk:getWeather() == xi.weather.GALES) and
            puk:getMod(xi.mod.REGAIN) == 0
        then
            puk:setMod(xi.mod.REGAIN, 30)
        elseif
            VanadielDayOfTheWeek() ~= xi.day.WINDSDAY and
            puk:getWeather() == xi.weather.WIND and
            puk:getWeather() == xi.weather.GALES and
            puk:getMod(xi.mod.REGAIN) ~= 0
        then
            puk:setMod(xi.mod.REGAIN, 0)
        end
    end)
end

return g_mixins.families.puk
