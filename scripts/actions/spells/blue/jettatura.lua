-----------------------------------
-- Spell: Jettatura
-- Enemies within a fan-shaped area originating from the caster are frozen with fear
-- Spell cost: 37 MP
-- Monster Type: Birds
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MP+15
-- Level: 48
-- Casting Time: 0.5 seconds
-- Recast Time: 2:00
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.BIRD
    params.effect          = xi.effect.TERROR
    params.power           = 1
    params.tick            = 0
    params.duration        = 5
    params.resistThreshold = 0.5
    params.isGaze          = true
    params.isConal         = true

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
