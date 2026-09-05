-----------------------------------
-- Spell: Wild Oats
-- Additional effect: Vitality Down. Duration of effect varies on TP
-- Spell cost: 9 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+1, HP+10
-- Level: 4
-- Casting Time: 0.5 seconds
-- Recast Time: 7.25 seconds
-- Skillchain Element(s): Transfixion
-- Combos: Beast Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.PLANTOID
    params.tpModifier     = xi.spells.blue.tpMod.DURATION
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.skillchainType = xi.skillchainType.TRANSFIXION

    params.numHits       = 1
    params.ftp0          = 1.8359375
    params.ftp1500       = 1.8359375
    params.ftp3000       = 1.8359375
    params.ftpAzure      = 1.8359375
    params.baseDamageCap = 11

    params.agi_wsc = 0.3

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if params.hitsLanded <= 0 then
        return damage
    end

    local duration = 180

    -- TODO: duration needs verification
    if params.hasAzureLore then
        duration = 450
    elseif params.hasChainAffinity then
        duration = xi.spells.blue.calculatefTP(caster:getTP(), 180, 360, 400)
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.VIT_DOWN, 9, 6, duration },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
