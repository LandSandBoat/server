-----------------------------------
-- Spell: Chaotic Eye
-- Silences an enemy
-- Spell cost: 13 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 32
-- Casting Time: 3 seconds
-- Recast Time: 10 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Conserve MP
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.BEAST
    params.effect = xi.effect.SILENCE
    local power = 1
    local tick = 0
    local duration = 120
    local resistThreshold = 0.5
    local isGaze = true
    local isConal = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params, power, tick, duration, resistThreshold, isGaze, isConal)
end

return spellObject
