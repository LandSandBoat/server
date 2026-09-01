-----------------------------------
-- Spell: Seedspray
-- Delivers a threefold attack. Additional effect: Weakens defense. Chance of effect varies with TP
-- Spell cost: 61 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 61
-- Casting Time: 4 seconds
-- Recast Time: 35 seconds
-- Skillchain Element(s): Induration/Detonation
-- Combos: Beast Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem       = xi.ecosystem.PLANTOID
    params.tpModifier      = xi.spells.blue.tpMod.DURATION
    params.attackType      = xi.attackType.PHYSICAL
    params.damageType      = xi.damageType.SLASHING
    params.skillchainType  = xi.skillchainType.INDURATION
    params.skillchainType2 = xi.skillchainType.DETONATION

    params.numHits       = 3
    params.ftp0          = 0.875
    params.ftp1500       = 0.875
    params.ftp3000       = 0.875
    params.ftpAzure      = 0.875
    params.baseDamageCap = 69

    params.dex_wsc    = 0.3

    -- Handle damage.
    local damage, hitsLanded = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if hitsLanded <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.DEFENSE_DOWN, 8, 0, 120 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
