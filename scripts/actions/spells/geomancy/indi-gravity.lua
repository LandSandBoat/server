-----------------------------------
-- Spell: Indi-Gravity
-- Weighs down enemies near the caster.
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.job_utils.geomancer.indiOnMagicCastingCheck(caster, target, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.job_utils.geomancer.doIndiSpell(caster, target, spell)
end

return spellObject
