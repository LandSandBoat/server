-----------------------------------
-- Spell: Quadratic Continuum
-- Delivers a fourfold attack. Damage varies with TP
-- Spell cost: 91 MP
-- Monster Type: Empty
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+3 CHR-2
-- Level: 85
-- Casting Time: 1 seconds
-- Recast Time: 31.75 seconds
-- Skillchain Element(s): Distortion/Scission
-- Combos: Dual Wield
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.EMPTY
    params.tpmod = xi.spells.blue.tpMod.DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.scattr = xi.skillchainType.DISTORTION
    params.scattr2 = xi.skillchainType.SCISSION
    params.numhits = 4
    params.multiplier = 1.25
    params.tp150 = 1.5
    params.tp300 = 1.75
    params.azuretp = 2.0
    params.duppercap = 75
    params.str_wsc = 0.32
    params.dex_wsc = 0.0
    params.vit_wsc = 0.32
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
