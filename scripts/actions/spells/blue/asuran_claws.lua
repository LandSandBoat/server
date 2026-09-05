-----------------------------------
-- Spell: Asuran Claws
-- Delivers a sixfold attack. Accuracy varies with TP
-- Spell cost: 81 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: AGI +3
-- Level: 70
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Skillchain Element(s): Liquefaction/Impaction
-- Combos: Counter
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.BEAST
    params.tpModifier = xi.spells.blue.tpMod.ACC

    -- TODO: made up
    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.HAND_TO_HAND
    params.skillchainType  = xi.skillchainType.LIQUEFACTION
    params.skillchainType2 = xi.skillchainType.IMPACTION

    params.numHits       = 6
    params.ftp0          = 0.625
    params.ftp1500       = 0.625
    params.ftp3000       = 0.625
    params.ftpAzure      = 0.625
    params.baseDamageCap = 999 -- uncapped in retail. was 21 here before?
    params.attackMult    = 1.05

    -- D seems low for its level, but the spell never did good damage, so a low D is a good way of keeping overall damage down.
    -- More discussion on https://ffxiclopedia.fandom.com/wiki/Talk:Asuran_Claws
    params.str_wsc = 0.1
    params.dex_wsc = 0.1

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
