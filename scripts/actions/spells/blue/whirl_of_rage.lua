-----------------------------------
-- Spell: Whirl of Rage
-- Delivers a slashing attack. Additional effect: Stun
-- Spell cost: 73 MP
-- Monster Type: Demon
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: STR+3, MND+3
-- Level: 83
-- Casting Time: 0.5 seconds
-- Recast Time: 30 seconds
-- Combos: Zanshin
-----------------------------------
-- Research from BG-Wiki:
-- - WSC: 30% STR, 30% MND
-- - fTP: 3.0 (Base), 3.5 (1500 TP), 4.0 (3000 TP)
-- - Additional Effect: Stun
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.DEMON
    params.tpmod = xi.spells.blue.tpMod.DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.numhits = 1
    params.multiplier = 3.0
    params.tp150 = 3.5
    params.tp300 = 4.0
    params.azuretp = 4.25
    params.duppercap = 84  -- Level 83 spell
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage > 0 then
        -- Stun effect
        local effectTable =
        {
            [1] = { xi.effect.STUN, 1, 0, 3 },
        }

        xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)
    end

    return damage
end

return spellObject
