-----------------------------------
-- Spell: Pinecone Bomb
-- Additional effect: Sleep. Duration of effect varies with TP
-- Spell cost: 48 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: STR+1
-- Level: 36
-- Casting Time: 2.5 seconds
-- Recast Time: 26.5 seconds
-- Skillchain Element(s): Liquefaction
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
    params.skillchainType = xi.skillchainType.LIQUEFACTION

    params.numHits       = 1
    params.ftp0          = 2.25
    params.ftp1500       = 2.25
    params.ftp3000       = 2.25
    params.ftpAzure      = 2.25
    params.baseDamageCap = 37

    params.str_wsc    = 0.2
    params.agi_wsc    = 0.2

    -- Handle damage.
    local damage, hitsLanded = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if hitsLanded <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.SLEEP_I, 1, 0, 60 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
