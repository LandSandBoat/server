-----------------------------------
-- Spell: Tourbillion
-- Delivers a physical attack to enemies within area of effect. Additional effect: Defense Down
-- Spell cost: 108 MP
-- Monster Type: Dragon
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: None
-- Level: 97
-- Casting Time: 3 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: None
-----------------------------------
-- Notes: Requires Unbridled Learning.
-- PROXY FORMULA: Based on Benthic Typhoon (WSC 60% AGI, fTP 4.0-5.25, Defense Down)
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
    -- PROXY: Using Benthic Typhoon formula
    local params = {}
    params.ecosystem = xi.ecosystem.DRAGON
    params.tpmod = xi.spells.blue.tpMod.DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.numhits = 1
    params.multiplier = 4.0
    params.tp150 = 4.5
    params.tp300 = 5.0
    params.azuretp = 5.25
    params.duppercap = 98
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.6
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Defense Down
        local effectTable =
        {
            [1] = { xi.effect.DEFENSE_DOWN, 10, 0, 60 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
