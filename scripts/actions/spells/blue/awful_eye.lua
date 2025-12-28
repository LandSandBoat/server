-----------------------------------
-- Spell: Awful Eye
-- Lowers Strength of enemies within a fan-shaped area originating from the caster
-- Spell cost: 32 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Water)
-- Blue Magic Points: 2
-- Stat Bonus: MND+1
-- Level: 46
-- Casting Time: 2.5 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Clear Mind
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.LIZARD
    params.effect          = xi.effect.STR_DOWN
    params.power           = 30
    params.tick            = 1
    params.duration        = 30
    params.resistThreshold = 0.5
    params.isGaze          = true
    params.isConal         = true

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
