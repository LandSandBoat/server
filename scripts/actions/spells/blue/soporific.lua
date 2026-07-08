-----------------------------------
-- Spell: Soporific
-- Puts all enemies within range to sleep
-- Spell cost: 38 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+5
-- Level: 24
-- Casting Time: 3 seconds
-- Recast Time: 90 seconds
-- Duration: 90 seconds
-- Magic Bursts on: Compression, Gravitation, and Darkness
-- Combos: Clear Mind
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.PLANTOID
    params.effect          = xi.effect.SLEEP_I
    params.power           = 2
    params.tick            = 0
    params.duration        = 90
    params.resistThreshold = 0.50
    params.isGaze          = false
    params.isConal         = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
