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
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.BEAST
    params.effect          = xi.effect.SILENCE
    params.power           = 1
    params.tick            = 0
    params.duration        = 120
    params.resistThreshold = 0.5
    params.isGaze          = true
    params.isConal         = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
