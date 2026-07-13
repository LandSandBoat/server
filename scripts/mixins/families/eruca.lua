-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
-----------------------------------

g_mixins.families.eruca = function(erucaMob)
    erucaMob:addListener('ROAM_TICK', 'ERUCA_ROAM_TICK', function(mob)
        if
            VanadielDayElement() == xi.element.FIRE and
            mob:getMod(xi.mod.REGAIN) == 0
        then
            mob:setMod(xi.mod.REGAIN, 30)
        elseif
            VanadielDayElement() ~= xi.element.FIRE and
            mob:getMod(xi.mod.REGAIN) ~= 0
        then
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end)

    erucaMob:addListener('COMBAT_TICK', 'ERUCA_COMBAT_TICK', function(mob)
        if
            VanadielDayElement() == xi.element.FIRE and
            mob:getMod(xi.mod.REGAIN) == 0
        then
            mob:setMod(xi.mod.REGAIN, 30)
        elseif
            VanadielDayElement() ~= xi.element.FIRE and
            mob:getMod(xi.mod.REGAIN) ~= 0
        then
            mob:setMod(xi.mod.REGAIN, 0)
        end
    end)
end

return g_mixins.families.eruca
