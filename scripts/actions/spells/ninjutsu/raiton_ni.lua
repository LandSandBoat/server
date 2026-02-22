-----------------------------------
-- Spell: Raiton: Ni
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 15 + caster:getMerit(xi.merit.RAITON_EFFECT) -- T1 bonus debuff duration
    target:addStatusEffect(xi.effect.NINJUTSU_ELE_DEBUFF, { power = 30, duration = duration, origin = caster, icon = 0, subPower = xi.mod.EARTH_MEVA })

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
