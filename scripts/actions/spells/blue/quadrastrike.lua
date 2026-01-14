-----------------------------------
-- Spell: Quadrastrike
-- Delivers a fourfold attack. Chance of critical hit varies with TP.
-- Spell cost: 98 MP
-- Monster Type: Demons
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 5
-- Stat Bonus: STR+3 CHR+3
-- Level: 96
-- Casting Time: 2 seconds
-- Recast Time: 42.5 seconds
-- Skillchain Element(s): Liquefaction, Scission
-- Combos: Sillchain Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Missing proper info and logic for crit.
    local params = {}
    params.ecosystem = xi.ecosystem.DEMON
    params.tpmod = xi.spells.blue.tpMod.CRITHITRATE
    params.bonusacc = 0
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.bonusacc = 70
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.bonusacc = math.floor(caster:getTP() / 50)
    end

    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr = xi.skillchainType.LIQUEFACTION
    params.scattr2 = xi.skillchainType.SCISSION
    params.numhits = 4
    params.multiplier = 1.1875
    params.tp150 = 1.1875
    params.tp300 = 1.1875
    params.azuretp = 1.1875
    params.duppercap = 100
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.critchance = 30 -- Guessed, this probably scales with TP, BG wiki says 33% which likely includes base crit rate so we're reducing it a bit lower

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
