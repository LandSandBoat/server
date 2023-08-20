-----------------------------------
-- Spell: Threnody - xi.mod.FIRE_MEVA
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return handleThrenody(caster, target, spell, 50, 60, xi.mod.FIRE_MEVA)
end

return spellObject
