-----------------------------------
-- Spell: Pining Nocturne
-- Main effect: Increases the casting time of the target.
-- Sub effect : Lowers target magic accuracy.
-- Does not stack with Addle. Is overwritten by Addle.
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
