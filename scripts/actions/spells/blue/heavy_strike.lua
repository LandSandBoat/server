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
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem       = xi.ecosystem.ARCANA
    params.tpModifier      = xi.spells.blue.tpMod.ATTACK
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.HAND_TO_HAND
    params.skillchainType  = xi.skillchainType.FRAGMENTATION
    params.skillchainType2 = xi.skillchainType.TRANSFIXION

    params.numHits       = 1
    params.ftp0          = 2.5 -- Using https://wiki.ffo.jp/html/24367.html over bg-wiki for this
    params.ftp1500       = 3.5
    params.ftp3000       = 4.0
    params.ftpAzure      = 4.0 -- This is a guess as blue gartr doesn't have this info
    params.baseDamageCap = 75
    params.bonusAcc      = -100
    params.critChance    = 100 -- TODO: this should cap to 100%

    params.str_wsc = 0.5

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
