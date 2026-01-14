-----------------------------------
-- Spell: Heavy Strike
-- Damage varies with TP
-- Spell cost: 32 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: STR+2
-- Level: 92
-- Casting Time: 1 seconds
-- Recast Time: 30 seconds
-- Skillchain Element(s): Fragmentation, Transfixion
-- Combos: Double Attack, Triple Attack
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

-- Need to implement Automatic crit
spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.ARCANA
    params.tpmod = xi.spells.blue.tpMod.ATTACK
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.scattr = xi.skillchainType.FRAGMENTATION
    params.scattr2 = xi.skillchainType.TRANSFIXION
    params.numhits = 1
    params.multiplier = 2.5 -- Using https://wiki.ffo.jp/html/24367.html over bg-wiki for this
    params.tp150 = 3.5
    params.tp300 = 4.0
    params.azuretp = 4.0 -- This is a guess as blue gartr doesn't have this info
    params.duppercap = 75
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.bonusacc = -100
    params.critchance = 100 -- TODO: this should cap to 100%

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
