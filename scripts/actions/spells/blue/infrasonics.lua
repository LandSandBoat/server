-----------------------------------
-- Spell: Infrasonics
-- Lowers the evasion of enemies within a fan-shaped area originating from the caster
-- Spell cost: 42 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 4
-- Stat Bonus: INT+1
-- Level: 65
-- Casting Time: 5 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Induration, Distortion, Darkness
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.LIZARD
    params.effect          = xi.effect.EVASION_DOWN
    params.power           = 20
    params.tick            = 0
    params.duration        = 60
    params.resistThreshold = 0.5
    params.isGaze          = false
    params.isConal         = true

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
