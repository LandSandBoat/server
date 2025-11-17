-----------------------------------
-- Spell: Thunderbolt
-- Deals lightning damage to a single target
-- Spell cost: 160 MP
-- Monster Type: Elemental
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 1
-- Stat Bonus: None
-- Level: 95
-- Casting Time: 5 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning.
-- PROXY FORMULA: Based on Dark Orb (WSC 40% INT, fTP 4.5, dINT 2.0)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Requires Unbridled Learning
    if not caster:hasStatusEffect(xi.effect.UNBRIDLED_LEARNING) then
        return xi.msg.basic.STATUS_PREVENTS
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Dark Orb formula
    local params = {}
    params.ecosystem   = xi.ecosystem.ELEMENTAL
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.LIGHTNING
    params.attribute   = xi.mod.INT
    params.multiplier  = 4.5
    params.tMultiplier = 2.0
    params.duppercap   = 96
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.4
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
