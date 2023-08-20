-----------------------------------
-- Spell: Foil
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

-- https://www.ffxiah.com/forum/topic/56696/foil-potency-and-decay-testing/#3625542
spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spellObject
