-----------------------------------
-- Spell: Droning Whirlwind
-- Deals wind damage to a single target
-- Spell cost: 188 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: None
-- Level: 99
-- Casting Time: 5 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning.
-- PROXY FORMULA: Based on Acrid Stream (WSC 30% MND, fTP 2.296875, dINT 2.0)
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
    -- PROXY: Using Acrid Stream formula
    local params = {}
    params.ecosystem   = xi.ecosystem.VERMIN
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.WIND
    params.attribute   = xi.mod.INT
    params.multiplier  = 2.296875
    params.tMultiplier = 2.0
    params.duppercap   = 99
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.3
    params.chr_wsc     = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
