-----------------------------------
-- Spell: Radiant Breath
-- Deals light damage to enemies within a fan-shaped area of effect originating from the caster. Additional effect: Slow and Silence.
-- Spell cost: 116 MP
-- Monster Type: Dragons
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+1, HP+5
-- Level: 54
-- Casting Time: 5.25 seconds
-- Recast Time: 33.75 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.DRAGON
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.LIGHT
    params.diff = 0 -- no stat increases magic accuracy
    params.skillType = xi.skill.BLUE_MAGIC
    params.hpMod = 5
    params.lvlMod = 0.75

    local results = blueDoBreathSpell(caster, target, spell, params, true)
    local damage = results[1]
    local resist = results[2]
    damage = blueFinalizeDamage(caster, target, spell, damage, params)

    local duration = 60 -- 30s/60s
    if resist >= 0.5 then
        -- Added effect: Slow (25%)
        target:addStatusEffect(xi.effect.SLOW, 2500, 0, duration * resist)
        -- Added effect: Silence
        target:addStatusEffect(xi.effect.SILENCE, 25, 0, duration * resist)
    end

    return damage
end

return spellObject
