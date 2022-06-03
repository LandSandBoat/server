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
        -- If the element corresponding to the elemental day of the in-game Vana'diel week is used on a Puk, it will get 100% TP instantly. 
        if damageType == xi.damageType.FIRE and VanadielDayOfTheWeek() == xi.day.FIRESDAY then
            puk:addTP(3000)
        elseif damageType == xi.damageType.EARTH and VanadielDayOfTheWeek() == xi.day.EARTHSDAY then
            puk:addTP(3000)
        elseif damageType == xi.damageType.WATER and VanadielDayOfTheWeek() == xi.day.WATERSDAY then
            puk:addTP(3000)
        elseif damageType == xi.damageType.WIND and VanadielDayOfTheWeek() == xi.day.WINDSDAY then
            puk:addTP(3000)
        elseif damageType == xi.damageType.ICE and VanadielDayOfTheWeek() == xi.day.ICEDAY then
            puk:addTP(3000)
        elseif damageType == xi.damageType.LIGHTNING and VanadielDayOfTheWeek() == xi.day.LIGHTNINGSDAY then
            puk:addTP(3000)
        elseif damageType == xi.damageType.LIGHT and VanadielDayOfTheWeek() == xi.day.LIGHTSDAY then
            puk:addTP(3000)
        elseif damageType == xi.damageType.DARK and VanadielDayOfTheWeek() == xi.day.DARKSDAY then
            puk:addTP(3000)
        end
    end)

    mob:addListener("ROAM_TICK", "PUK_ROAM_TICK", function(puk)
        if VanadielDayOfTheWeek() == xi.day.WINDSDAY and puk:getMod(xi.mod.REGAIN) == 0 then
            puk:setMod(xi.mod.REGAIN, 30)
        elseif VanadielDayOfTheWeek() ~= xi.day.WINDSDAY and puk:getMod(xi.mod.REGAIN) ~= 0 then
            puk:setMod(xi.mod.REGAIN, 0)
        end
    end)
end

return g_mixins.families.puk
