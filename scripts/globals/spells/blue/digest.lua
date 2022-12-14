-----------------------------------
-- Spell: Digest
-- Steals an enemy's HP. Ineffective against undead
-- Spell cost: 20 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 36
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
<<<<<<< refs/remotes/upstream/base
<<<<<<< refs/remotes/upstream/base
    local dmg = 5 + 0.575 * caster:getSkillLevel(xi.skill.BLUE_MAGIC)
=======


>>>>>>> Renamed BLU functions, added drain function (yet to rewire), used existing systemStrength table
    --get resist multiplier (1x if no resist)
=======
>>>>>>> Drain spells, enhancing spells, merit fixes
    local params = {}
    params.ecosystem = xi.ecosystem.AMORPH
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.DARK
    params.diff = 0 -- no stat increases magic accuracy
    params.skillType = xi.skill.BLUE_MAGIC
    params.dmgMultiplier = 5

    return bluDoDrainSpell(caster, target, spell, params, 0, false)
end

return spellObject
