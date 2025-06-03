-----------------------------------
-- Spell: Filamented Hold
-- Reduces the attack speed of enemies within a fan-shaped area originating from the caster
-- Spell cost: 38 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1
-- Level: 52
-- Casting Time: 2 seconds
-- Recast Time: 20 seconds
-- Magic Bursts on: Scission, Gravitation, and Darkness
-- Combos: Clear Mind
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.VERMIN
    params.effect          = xi.effect.SLOW
    params.power           = 2500
    params.tick            = 0
    params.duration        = 90
    params.resistThreshold = 0.5
    params.isGaze          = false
    params.isConal         = true

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
