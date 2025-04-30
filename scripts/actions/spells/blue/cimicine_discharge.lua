-----------------------------------
-- Spell: Cimicine Discharge
-- Reduces the attack speed of enemies within range
-- Spell cost: 32 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+1, AGI+2
-- Level: 78
-- Casting Time: 3 seconds
-- Recast Time: 20 seconds
-----------------------------------
-- Combos: Magic Burst Bonus
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
    params.power           = 2000
    params.tick            = 0
    params.duration        = 90
    params.resistThreshold = 0.5
    params.isGaze          = false
    params.isConal         = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
