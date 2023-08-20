-----------------------------------
-- Spell: Flying Hip Press
-- Deals wind damage to enemies within range
-- Spell cost: 125 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+1
-- Level: 58
-- Casting Time: 5.75 seconds
-- Recast Time: 34.5 seconds
-- Magic Bursts On: Detonation, Fragmentation, and Light
-- Combos: Max HP Boost
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.WIND
    params.diff = 0 -- no stat increases magic accuracy
    params.skillType = xi.skill.BLUE_MAGIC
    params.hpMod = 3
    params.lvlMod = 0

    local results = xi.spells.blue.useBreathSpell(caster, target, spell, params, false)
    local damage = results[1]

    return damage
end

return spellObject
