-----------------------------------
-- Spell: Battle Dance
-- Delivers an area attack. Additional effect: DEX Down. Duration of effect varies with TP
-- Spell cost: 12 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2
-- Level: 12
-- Casting Time: 1 second
-- Recast Time: 10 seconds
-- Skillchain Element(s): Impaction
-- Combos: Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.BEASTMEN
    params.tpModifier     = xi.spells.blue.tpMod.DURATION
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.skillchainType = xi.skillchainType.IMPACTION

    params.numHits       = 1
    params.ftp0          = 2.0
    params.ftp1500       = 2.0
    params.ftp3000       = 2.0
    params.ftpAzure      = 2.0
    params.baseDamageCap = 17
    params.str_wsc       = 0.3

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if params.hitsLanded <= 0 then
        return damage
    end

    local duration = 90

    -- TODO: 0tp duration needs verification
    if params.hasAzureLore then
        duration = 800
    elseif params.hasChainAffinity then
        duration = xi.spells.blue.calculatefTP(caster:getTP(), 90, 480, 680)
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.DEX_DOWN, 9, 6, duration },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
