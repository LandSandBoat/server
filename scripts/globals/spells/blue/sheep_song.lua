-----------------------------------
-- Spell: Sheep Song
-- Puts all enemies within range to sleep
-- Spell cost: 22 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: CHR+1, HP+5
-- Level: 16
-- Casting Time: Casting Time: 3 seconds
-- Recast Time: Recast Time: 60 seconds
-- Duration: 60 seconds
-- Magic Bursts on: Transfixion, Fusion, and Light
-- Combos: Auto Regen
-----------------------------------
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
    params.effect = xi.effect.SLEEP_I
    local power = 1
    local tick = 0
    local duration = 60
    local resistThreshold = 0.50
    local isGaze = false
    local isConal = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params, power, tick, duration, resistThreshold, isGaze, isConal)
end

return spellObject
