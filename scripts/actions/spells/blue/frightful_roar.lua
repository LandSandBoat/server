-----------------------------------
-- Spell: Frightful Roar
-- Weakens defense of enemies within range
-- Spell cost: 32 MP
-- Monster Type: Demon
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+2
-- Level: 50
-- Casting Time: 2 seconds
-- Recast Time: 20 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Auto Refresh
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.DEMON
    params.effect          = xi.effect.DEFENSE_DOWN
    params.power           = 10
    params.tick            = 0
    params.duration        = 180
    params.resistThreshold = 0.5
    params.isGaze          = false
    params.isConal         = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
