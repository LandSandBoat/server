-----------------------------------
-- Spell: Sandspray
-- Blinds enemies within a fan-shaped area originating from the caster
-- Spell cost: 43 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 66
-- Casting Time: 3 seconds
-- Recast Time: 90 seconds
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
    params.ecosystem       = xi.ecosystem.BEASTMEN
    params.effect          = xi.effect.BLINDNESS
    params.power           = 25
    params.tick            = 0
    params.duration        = 120
    params.resistThreshold = 0.5
    params.isGaze          = false
    params.isConal         = true

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
