-----------------------------------
-- Spell: Frost Breath
-- Deals ice damage to enemies within a fan-shaped area originating from the caster. Additional effect: Paralysis
-- Spell cost: 136 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Ice)
-- Blue Magic Points: 3
-- Stat Bonus: INT-2
-- Level: 66
-- Casting Time: 6.5 seconds
-- Recast Time: 42.75 seconds
-- Magic Bursts on: Induration, Distortion, and Darkness
-- Combos: Conserve MP
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.LIZARD
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.ICE
    params.diff = 0 -- no stat increases magic accuracy
    params.skillType = xi.skill.BLUE_MAGIC
    params.hpMod = 3
    params.lvlMod = 0.625

    local results = xi.spells.blue.useBreathSpell(caster, target, spell, params, true)
    local damage = results[1]
    local resist = results[2]

    if resist >= 0.5 then
        target:addStatusEffect(xi.effect.PARALYSIS, 15, 0, 60 * resist)
    end

    return damage
end

return spellObject
