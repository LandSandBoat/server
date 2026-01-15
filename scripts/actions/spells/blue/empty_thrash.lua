-----------------------------------
-- Spell: Empty Thrash
-- Delivers an area attack. Accuracy varies with TP
-- Spell cost: 33 MP
-- Monster Type: Empty
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: STR+3 CHR-2
-- Level: 87
-- Casting Time: 0.5 seconds
-- Recast Time: 40.75 seconds
-- Skillchain Element(s): Compression, Scission
-- Combos: Doule Attack, Triple Attack
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem  = xi.ecosystem.EMPTY
    params.tpmod = xi.spells.blue.tpMod.ACC
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr = xi.skillchainType.COMPRESSION
    params.scattr2 = xi.skillchainType.SCISSION
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 33
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
