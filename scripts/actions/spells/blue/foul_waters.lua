-----------------------------------
-- Spell: Foul Waters
-- Deals water damage to a single target. Additional effect: Poison
-- Spell cost: 184 MP
-- Monster Type: Amorph
-- Spell Type: Magical (Water)
-- Blue Magic Points: 8
-- Stat Bonus: MND+5, CHR+5
-- Level: 99
-- Casting Time: 5 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: Resist Silence
-----------------------------------
-- Notes: PROXY FORMULA: Based on Acrid Stream (WSC 30% MND, fTP 2.296875, dINT 2.0)
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Acrid Stream formula
    local params = {}
    params.ecosystem   = xi.ecosystem.AMORPH
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.WATER
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

    if damage > 0 then
        -- Poison effect (potency unknown, using 5 HP/tick)
        local effectTable =
        {
            [1] = { xi.effect.POISON, 5, 3, 60 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
