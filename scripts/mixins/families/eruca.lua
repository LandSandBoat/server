-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
-----------------------------------

g_mixins.families.eruca = function(erucaMob)
    erucaMob:addListener('SPAWN', 'ERUCA_SPAWN', function(mob)
        if xi.data.element.getWeatherElement(mob:getWeather()) == xi.element.FIRE then
            mob:setMod(xi.mod.REGAIN, 150)
        end
    end)

    erucaMob:addListener('WEATHER_CHANGE', 'ERUCA_WEATHER_CHANGE', function(mob, weather, element)
        if not mob:isAlive() then
            return
        end

        if element == xi.element.FIRE then
            mob:setMod(xi.mod.REGAIN, 150)
        else
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end)

    erucaMob:addListener('ENGAGE', 'ERUCA_ENGAGE', function(mob)
        if mob:isCharmed() then
            return
        end

        -- If fire weather is active, Eruca will instantly use a mobskill when they engage.
        if xi.data.element.getWeatherElement(mob:getWeather()) == xi.element.FIRE then
            mob:setTP(3000)
        end
    end)

    erucaMob:addListener('DESPAWN', 'ERUCA_DESPAWN', function(mob)
        mob:setMod(xi.mod.REGAIN, 0)
    end)
end

return g_mixins.families.eruca
