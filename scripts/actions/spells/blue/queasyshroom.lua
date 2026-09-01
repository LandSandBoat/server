-----------------------------------
-- Spell: Queasyshroom
-- Additional effect: Poison. Duration of effect varies with TP
-- Spell cost: 20 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 8
-- Casting Time: 2 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s): Compression
-- Combos: None
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
    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.PIERCING
    params.skillchainType = xi.skillchainType.COMPRESSION

    params.numHits       = 1
    params.ftp0          = 1.75
    params.ftp1500       = 1.75
    params.ftp3000       = 1.75
    params.ftpAzure      = 1.75
    params.baseDamageCap = 15

    params.int_wsc = 0.2

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if params.hitsLanded <= 0 then
        return damage
    end

    local duration = 90

    -- TODO: duration needs verification
    if params.hasAzureLore then
        duration = 210
    elseif params.hasChainAffinity then
        duration = xi.spells.blue.calculatefTP(caster:getTP(), 90, 150, 180)
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.POISON, 3, 3, duration },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
