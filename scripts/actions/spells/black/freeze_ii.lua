-----------------------------------
-- Spell: Freeze II
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    target:addStatusEffectEx(xi.effect.NINJUTSU_ELE_DEBUFF, 0, 30, 0, 10, 0, xi.mod.FIRE_MEVA, 0)

    return xi.spells.damage.useDamageSpell(caster, target, spell)
end

return spellObject
