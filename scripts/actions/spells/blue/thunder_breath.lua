-----------------------------------
-- Spell: Thunder Breath
-- Deals lightning damage to enemies within a fan-shaped area
-- Spell cost: 193 MP
-- Monster Type: Dragon
-- Spell Type: Breath (Lightning)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2, DEX+2
-- Level: 97
-- Casting Time: 6 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: Max HP Boost
-----------------------------------
-- Notes: PROXY FORMULA: Breath spell scaling with Current HP * 0.25
-- Breath spells scale with current HP, not stats
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Breath formula with 0.25 multiplier
    local params = {}
    params.ecosystem  = xi.ecosystem.DRAGON
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.THUNDER
    params.diff       = 0
    params.skillType  = xi.skill.BLUE_MAGIC
    params.hpMod      = 4  -- 0.25 multiplier (higher than frost breath)
    params.lvlMod     = 0.625
    params.isConal    = true

    local damage = xi.spells.blue.useBreathSpell(caster, target, spell, params)

    return damage
end

return spellObject
