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

        -- Day element damage gives TP.
        if damageType == elementTable[VanadielDayOfTheWeek()] then
            puk:addTP(1000)
        end
    end)

    mob:addListener('MAGIC_TAKE', 'PUK_MAGIC_TAKE', function(puk, caster, spell)
        -- On Windsday, wind damage spells grant TP (excluding dot).
        if
            VanadielDayOfTheWeek() == xi.day.WINDSDAY and
            spell:getElement() == xi.element.WIND and
            spell:getSkillType() == xi.skill.ELEMENTAL_MAGIC and
            spell:getSpellFamily() ~= xi.magic.spellFamily.ELE_DOT and
            puk:getMod(xi.mod.WIND_ABSORB) > 0
        then
            puk:addTP(1000)
        end
    end)
end

return g_mixins.families.puk
