-----------------------------------
-- Spell: Sprout Smack
-- Additional effect: Slow. Duration of effect varies with TP
-- Spell cost: 6 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: MND+1
-- Level: 4
-- Casting Time: 0.5 seconds
-- Recast Time: 7.25 seconds
-- Skillchain property: Reverberation
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
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.REVERBERATION

    params.numHits       = 1
    params.ftp0          = 1.5
    params.ftp1500       = 1.5
    params.ftp3000       = 1.5
    params.ftpAzure      = 1.5
    params.baseDamageCap = 11

    params.vit_wsc = 0.3

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
        [1] = { xi.effect.SLOW, 1500, 0, duration },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
