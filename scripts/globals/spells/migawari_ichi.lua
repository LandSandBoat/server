-----------------------------------
-- Spell: Migawari: Ichi
-- Nullifies a Death Blow for the Caster
-- A Death Blow is, in general, Damage >= Max HP
-- Threshold for negation is thought to be reduced
-- by 1% for every 5 Ninjutsu Skill
--
-- Effect Power: Damage Threshold %
-- Effect Sub Power: Damage Reduction % (In this case, 100%)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.MIGAWARI
    local ninjutsu = target:getSkillLevel(xi.skill.NINJUTSU)
    local negationThreshold = math.floor(100 * ((ninjutsu / 5) / 100))
    caster:addStatusEffect(effect, negationThreshold, 0, 60, 0, 100)
    return effect
end

return spell_object
