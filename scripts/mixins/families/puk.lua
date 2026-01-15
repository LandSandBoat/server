-----------------------------------
-- Puk family mixin
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
-----------------------------------

g_mixins.families.puk = function(mob)
    mob:addListener('TAKE_DAMAGE', 'PUK_TAKE_DAMAGE', function(puk, amount, attacker, attackType, damageType)
        local elementTable =
        {
            [xi.day.FIRESDAY    ] = xi.damageType.FIRE,
            [xi.day.EARTHSDAY   ] = xi.damageType.EARTH,
            [xi.day.WATERSDAY   ] = xi.damageType.WATER,
            [xi.day.WINDSDAY    ] = xi.damageType.WIND,
            [xi.day.ICEDAY      ] = xi.damageType.ICE,
            [xi.day.LIGHTNINGDAY] = xi.damageType.THUNDER,
            [xi.day.LIGHTSDAY   ] = xi.damageType.LIGHT,
            [xi.day.DARKSDAY    ] = xi.damageType.DARK,
        }

        -- If the element corresponding to the elemental day of the in-game Vana'diel week is used on a Puk, it will get 100% TP instantly.
        if damageType == elementTable[VanadielDayOfTheWeek()] then
            puk:addTP(1000)
        end
    end)
end

return g_mixins.families.puk
