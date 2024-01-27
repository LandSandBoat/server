-----------------------------------
-- Spell: Sickle Slash
-- Deals critical damage. Chance of critical hit varies with TP
-- Spell cost: 41 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+15
-- Level: 48
-- Casting Time: 0.5 seconds
-- Recast Time: 20.5 seconds
-- Skillchain Element: Compression
-- Combos: Store TP
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.VERMIN
    params.tpmod = TPMOD_CRITICAL
    params.critchance = 0
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        params.critchance = 55
    elseif caster:hasStatusEffect(xi.effect.CHAIN_AFFINITY) then
        params.critchance = math.floor(caster:getTP() / 75)
    end

    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.scattr = xi.skillchainType.COMPRESSION
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 1.5
    params.tp300 = 1.5
    params.azuretp = 1.5
    params.duppercap = 49
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
