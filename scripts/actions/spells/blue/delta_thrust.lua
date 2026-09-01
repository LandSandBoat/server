-----------------------------------
-- Spell: Delta Thrust
-- Delivers a threefold attack. Additional effect: Plague
-- Spell cost: 28 MP
-- Monster Type: Lizard
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: HP+15 MP-5 INT-1
-- Level: 89
-- Casting Time: 0.5 seconds
-- Recast Time: 15.0 seconds
-- Skillchain Element(s): Liquefaction/Detonation
-- Combos: Dual Wield
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params     = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem = xi.ecosystem.LIZARD

    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.skillchainType  = xi.skillchainType.LIQUEFACTION
    params.skillchainType2 = xi.skillchainType.DETONATION

    params.numHits       = 3
    params.ftp0          = 1.0
    params.ftp1500       = 1.0
    params.ftp3000       = 1.0
    params.ftpAzure      = 1.0
    params.baseDamageCap = 75

    params.str_wsc = 0.20
    params.vit_wsc = 0.50

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if params.hitsLanded <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.PLAGUE, 10, 3, 30 + math.randomInt(0, 30) }, -- https://wiki.ffo.jp/html/22338.html
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
