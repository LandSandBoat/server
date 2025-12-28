-----------------------------------
-- Spell: Temporal Shift
-- Enemies within range are temporarily prevented from acting
-- Spell cost: 48 MP
-- Monster Type: Luminians
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 5
-- Stat Bonus: HP+10, MP+15
-- Level: 73
-- Casting Time: 0.5 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Impaction, Fragmentation, and Light
-- Combos: Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.LUMINIAN
    params.effect          = xi.effect.STUN
    params.power           = 1
    params.tick            = 0
    params.duration        = 5
    params.resistThreshold = 0.25
    params.isGaze          = false
    params.isConal         = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
