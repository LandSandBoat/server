-----------------------------------
-- Spell: Threnody II - xi.mod.LIGHT_MEVA
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return handleThrenody(caster, target, spell, 160, 90, xi.mod.LIGHT_MEVA)
end

return spellObject
