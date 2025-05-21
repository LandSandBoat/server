-----------------------------------
-- Spell: Threnody - xi.mod.DARK_MEVA
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enfeebling.useEnfeeblingSong(caster, target, spell)
end

return spellObject
