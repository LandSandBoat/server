-----------------------------------
-- Spell: Sub-zero Smash
-- Additional Effect: Paralysis. Damage varies with TP
-- Spell cost: 44 MP
-- Monster Type: Aquans
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP+10 VIT+3
-- Level: 72
-- Casting Time: 1 second
-- Recast Time: 30 seconds
-- Skillchain Element(s): Fragmentation
-- Combos: Fast Cast
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params           = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.AQUAN
    params.tpModifier     = xi.spells.blue.tpMod.DAMAGE
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.FRAGMENTATION
    params.dStat          = xi.mod.INT

    params.numHits       = 1
    params.ftp0          = 2.0
    params.ftp1500       = 2.0
    params.ftp3000       = 2.0
    params.ftpAzure      = 2.0
    params.baseDamageCap = 72

    params.vit_wsc    = 0.6

    -- Handle damage.
    local damage, hitsLanded = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if hitsLanded <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.PARALYSIS, 10, 0, 180 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
