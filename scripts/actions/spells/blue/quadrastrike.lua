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
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.DEMON
    params.tpModifier = xi.spells.blue.tpMod.CRITICAL

    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.skillchainType  = xi.skillchainType.LIQUEFACTION
    params.skillchainType2 = xi.skillchainType.SCISSION

    params.numHits       = 4
    params.ftp0          = 1.1875
    params.ftp1500       = 1.1875
    params.ftp3000       = 1.1875
    params.ftpAzure      = 1.1875
    params.baseDamageCap = 100

    params.str_wsc = 0.3

    params.critChance = 30 -- Guessed, this probably scales with TP, BG wiki says 33% which likely includes base crit rate so we're reducing it a bit lower

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
