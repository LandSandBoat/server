-----------------------------------
-- Spell: Wind Breath
-- Deals wind damage to enemies within a fan-shaped area
-- Spell cost: 26 MP
-- Monster Type: Dragon
-- Spell Type: Breath (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: STR+2, AGI+2
-- Level: 99
-- Casting Time: 3 seconds
-- Recast Time: 30 seconds
-----------------------------------
-- Combos: Fast Cast
-----------------------------------
-- Notes: PROXY FORMULA: Breath spell scaling with Current HP * 0.15
-- Breath spells scale with current HP, not stats
-- Low MP cost suggests lower multiplier
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Breath formula with 0.15 multiplier (low due to low MP cost)
    local params = {}
    params.ecosystem  = xi.ecosystem.DRAGON
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.WIND
    params.diff       = 0
    params.skillType  = xi.skill.BLUE_MAGIC
    params.hpMod      = 7  -- 0.15 multiplier (~1/7 of current HP)
    params.lvlMod     = 0.625
    params.isConal    = true

    local damage = xi.spells.blue.useBreathSpell(caster, target, spell, params)

    return damage
end

return spellObject
