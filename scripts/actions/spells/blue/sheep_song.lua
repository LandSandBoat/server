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
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.BEAST
    params.effect          = xi.effect.SLEEP_I
    params.power           = 1
    params.tick            = 0
    params.duration        = 60
    params.resistThreshold = 0.50
    params.isGaze          = false
    params.isConal         = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
