-----------------------------------
-- Spell: Amorphic Spikes
-- Delivers a fivefold attack. Danage varies with TP
-- Spell cost: 79 MP
-- Monster Type: AMORPH
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: INT+5 MND+2
-- Level: 98
-- Casting Time: 0.5 seconds
-- Recast Time: 58.25 seconds
-- Skillchain Element(s): Gravitation/Transfixion
-- Combos: Gilfinder / Treasure Hunter
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.AMORPH
    params.tpModifier = xi.spells.blue.tpMod.ATTACK

    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.PIERCING
    params.skillchainType  = xi.skillchainType.GRAVITATION
    params.skillchainType2 = xi.skillchainType.TRANSFIXION

    params.numHits       = 5
    params.ftp0          = 1.0
    params.ftp1500       = 1.375
    params.ftp3000       = 1.750 -- as per https://wiki.ffo.jp/html/24665.html
    params.ftpAzure      = 2.125 -- guessing as no wiki has this info.
    params.baseDamageCap = 75

    params.dex_wsc = 0.20
    params.int_wsc = 0.20

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
