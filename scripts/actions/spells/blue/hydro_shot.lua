-----------------------------------
-- Spell: Hydro Shot
-- Additional effect: Enmity Down. Chance of effect varies with TP
-- Spell cost: 55 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: MND+2
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 26 seconds
-- Skillchain Element(s): Reverberation
-- Combos: Rapid Shot
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.BEASTMEN
    params.tpModifier     = xi.spells.blue.tpMod.EFFECT_CHANCE
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HAND_TO_HAND
    params.skillchainType = xi.skillchainType.REVERBERATION

    params.numHits       = 1
    params.ftp0          = 1.25
    params.ftp1500       = 1.25
    params.ftp3000       = 1.25
    params.ftpAzure      = 1.25
    params.baseDamageCap = 999 -- uncapped
    params.attackMult    = 1.85

    params.agi_wsc = 0.3

    -- Enmity Down amount is trivial, not worth implementing
    -- Sources: https://www.applySpellDamagethreads/37619-Blue-Mage-Best-thread-ever?p=4845494&viewfull=1#post4845494 and https://www.bg-wiki.com/ffxi/Hydro_Shot

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
