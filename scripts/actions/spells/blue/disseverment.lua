-----------------------------------
-- Spell: Disseverment
-- Delivers a fivefold attack. Additional effect: Poison. Accuracy varies with TP
-- Spell cost: 74 MP
-- Monster Type: Luminians
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 5
-- Stat Bonus: INT+1, MND-1
-- Level: 72
-- Casting Time: 0.5 seconds
-- Recast Time: 32.75 seconds
-- Skillchain Element(s): Distortion
-- Combos: Accuracy Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params       = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem   = xi.ecosystem.LUMINIAN
    params.tpModifier  = xi.spells.blue.tpMod.ACC

    -- TODO: made up
    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.skillchainType = xi.skillchainType.DISTORTION

    params.numHits       = 5
    params.ftp0          = 1.5
    params.ftp1500       = 1.5
    params.ftp3000       = 1.5
    params.ftpAzure      = 1.5
    params.baseDamageCap = 89
    params.attackMult    = 1.05

    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if params.hitsLanded <= 0 then
        return damage
    end

    -- Handle status effects.
    local power       = 3 + caster:getMainLvl() / 5
    local effectTable =
    {
        [1] = { xi.effect.POISON, power, 3, 180 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
