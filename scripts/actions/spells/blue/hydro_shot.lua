-----------------------------------
-- Spell: Hydro Shot
-- Additional effect: Enmity Down. Chance of effect varies with TP
-- Spell cost: 55 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: MND+2
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 26 seconds
-- Skillchain Element(s): Reverberation
-- Combos: Rapid Shot
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.tpmod = xi.spells.blue.tpMod.EFFECT_CHANCE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.scattr = xi.skillchainType.REVERBERATION
    params.numhits = 1
    params.multiplier = 1.25
    params.tp150 = 1.25
    params.tp300 = 1.25
    params.azuretp = 1.25
    params.duppercap = 75
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    -- Enmity Down amount is trivial, not worth implementing
    -- Sources: https://www.applySpellDamagethreads/37619-Blue-Mage-Best-thread-ever?p=4845494&viewfull=1#post4845494 and https://www.bg-wiki.com/ffxi/Hydro_Shot

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
