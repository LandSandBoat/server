-----------------------------------
-- Spell: Absorb-MND
-- Steals an enemy's mind.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.absorb.doAbsorbStatSpell(caster, target, spell)
end

return spellObject
