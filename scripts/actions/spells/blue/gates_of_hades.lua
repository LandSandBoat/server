-----------------------------------
-- Spell: Gates of Hades
-- Deals fire damage to enemies within area of effect. Additional effect: "Burn"
-- Spell cost: 70 MP (estimated)
-- Monster Type: Dragon
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 5
-- Stat Bonus: VIT+5, AGI+5
-- Level: 96
-- Casting Time: 6 seconds (estimated)
-- Recast Time: 60 seconds (estimated)
-- Magic Bursts on: Liquefaction, Fusion, Light
-- Combos: Magic Attack Bonus
-----------------------------------
-- Research from BG-Wiki:
-- - Burn Effect: 22 HP/tick, -47 INT
-- - Requires Unbridled Learning to cast
-- - AoE fire-based magical blue magic
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
    local params = {}
    params.ecosystem   = xi.ecosystem.DRAGON
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.FIRE
    params.attribute   = xi.mod.INT
    params.multiplier  = 3.5  -- Strong endgame spell
    params.tMultiplier = 2.5
    params.duppercap   = 120  -- High level spell cap
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.0
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.5
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    -- Handle damage
    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Handle Burn status effect
    -- Burn: 22 HP/tick, -47 INT
    local effectTable =
    {
        [1] = { xi.effect.BURN, 22, 0, 60, 47 },  -- power=22 HP/tick, subpower=47 INT down
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
