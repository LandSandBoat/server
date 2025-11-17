-----------------------------------
-- Spell: Adloquium
-- Gradually restores target's TP through Regain effect
-- Spell cost: 50 MP
-- Skill: Enhancing Magic
-- Level: SCH 88
-- Casting Time: 5 seconds
-- Recast Time: 18 seconds
-- Duration: Base 180 seconds
-----------------------------------
-- Effect: REGAIN (TP regeneration)
-- Base Power: 10 TP per tick (scales with Enhancing Magic Skill)
-- Tick Rate: 3 seconds
-- Formula: 1 TP per tick for every 10 Enhancing Magic Skill (cap at 500 skill = 50 TP/tick)
-- Maximum TP: 600 TP without Perpetuance (1500 TP with Perpetuance)
-----------------------------------
-- Affected by:
--   - Accession (makes it AoE)
--   - Perpetuance (extends duration)
--   - Composure (extends duration when cast on self or others)
-----------------------------------
-- Notes:
--   - Scholar-specific enhancing spell
--   - Does not strictly stack with other Regain sources
--   - Job abilities like Meditate and equipment bonuses do stack
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.spells.enhancing.useEnhancingSpell(caster, target, spell)
end

return spellObject
