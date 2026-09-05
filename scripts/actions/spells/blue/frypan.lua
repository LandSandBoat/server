-----------------------------------
-- Spell: Frypan
-- Delivers an area attack. Additional effect: "Stun." Accuracy varies with TP
-- Spell cost: 65 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2
-- Level: 63
-- Casting Time: 1 seconds
-- Recast Time: 26 seconds
-- Skillchain Element(s): Impcation
-- Combos: Max HP Boost
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.BEASTMEN
    params.tpModifier = xi.spells.blue.tpMod.ACC

    if params.hasAzureLore then
        params.bonusAcc = 70
    elseif params.hasChainAffinity then
        params.bonusAcc = math.floor(caster:getTP() / 50)
    end

    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.IMPACTION

    params.numHits       = 1
    params.ftp0          = 1.7734375
    params.ftp1500       = 1.7734375
    params.ftp3000       = 1.7734375
    params.ftpAzure      = 1.7734375
    params.baseDamageCap = 999 -- uncapped

    params.str_wsc    = 0.2
    params.mnd_wsc    = 0.2

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if params.hitsLanded <= 0 then
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
