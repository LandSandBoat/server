-----------------------------------
-- Spell: Vapor Spray
-- Deals water damage to enemies within a fan-shaped area
-- Spell cost: 151 MP
-- Monster Type: Plantoid
-- Spell Type: Breath (Water)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+2, INT+2
-- Level: 96
-- Casting Time: 5 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: Max MP Boost
-----------------------------------
-- Notes: PROXY FORMULA: Breath spell scaling with Current HP * 0.20
-- Breath spells scale with current HP, not stats
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Breath formula with 0.20 multiplier
    local params = {}
    params.ecosystem  = xi.ecosystem.PLANTOID
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.WATER
    params.diff       = 0
    params.skillType  = xi.skill.BLUE_MAGIC
    params.hpMod      = 5  -- 0.20 multiplier (1/5 of current HP)
    params.lvlMod     = 0.625
    params.isConal    = true

    local damage = xi.spells.blue.useBreathSpell(caster, target, spell, params)

    return damage
end

return spellObject
