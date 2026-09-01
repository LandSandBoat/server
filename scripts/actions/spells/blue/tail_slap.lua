-----------------------------------
-- Spell: Tail Slap
-- Delivers an area attack. Additional effect: "Stun." Damage varies with TP
-- Spell cost: 77 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: MND+2
-- Level: 69
-- Casting Time: 1 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Reverberation
-- Combos: Store TP
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.BEASTMEN
    params.tpModifier     = xi.spells.blue.tpMod.ATTACK
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HAND_TO_HAND
    params.skillchainType = xi.skillchainType.REVERBERATION
    params.dStat          = xi.mod.INT

    params.numHits       = 1
    params.ftp0          = 1.625
    params.ftp1500       = 1.625
    params.ftp3000       = 1.625
    params.ftpAzure      = 1.625
    params.baseDamageCap = 75

    params.str_wsc = 0.2
    params.vit_wsc = 0.5

    -- Handle damage.
    local damage, hitsLanded = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if hitsLanded <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.STUN, 1, 0, 5 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
