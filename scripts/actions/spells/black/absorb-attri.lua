-----------------------------------
-- Spell: Absorb-Attri
-- Steals an enemy's beneficial status effects.
-- NOTE: Nether Void allows for two beneficial status effects to be absorbed.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.absorb.doAbsorbAttriSpell(caster, target, spell)
end

return spellObject
