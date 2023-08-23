-----------------------------------
-- Spell: Bad Breath
-- Deals earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster
-- Spell cost: 212 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 5
-- Stat Bonus: INT+2, MND+2
-- Level: 61
-- Casting Time: 8.75 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Scission, Gravitation, Darkness
-- Combos: Fast Cast
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.PLANTOID
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.EARTH
    params.diff = 0 -- no stat increases magic accuracy
    params.skillType = xi.skill.BLUE_MAGIC
    params.hpMod = 8
    params.lvlMod = 3

    local results = xi.spells.blue.useBreathSpell(caster, target, spell, params, true)
    local damage = results[1]
    local resist = results[2]

    local duration = 60 -- 30s/60s
    if resist >= 0.5 then
        target:addStatusEffect(xi.effect.SLOW, 2000, 0, duration * resist)
        target:addStatusEffect(xi.effect.SILENCE, 1, 0, duration * resist)
        target:addStatusEffect(xi.effect.PARALYSIS, 15, 0, duration * resist)
        target:addStatusEffect(xi.effect.BIND, 1, 0, duration * resist)
        target:addStatusEffect(xi.effect.WEIGHT, 20, 0, duration * resist)
        target:addStatusEffect(xi.effect.POISON, 4, 0, duration * resist)
        target:addStatusEffect(xi.effect.BLINDNESS, 20, 0, duration * resist)
    end

    return damage
end

return spellObject
