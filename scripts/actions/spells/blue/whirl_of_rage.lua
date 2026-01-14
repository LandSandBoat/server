-----------------------------------
-- Spell: Whirl Of Rage
-- Delivers an area attack that stuns enemies. Damage varies with TP.
-- Spell cost: 73 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: STR+2 DEX+2
-- Level: 83
-- Casting Time: 1 second
-- Recast Time: 30 seconds
-- Skillchain Element(s): Scission, Detonation
-- Combos: Zanshin
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem  = xi.ecosystem.ARCANA
    params.tpmod      = xi.spells.blue.tpMod.DURATION
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr     = xi.skillchainType.SCISSION
    params.scattr2    = xi.skillchainType.DETONATION
    params.numhits    = 1
    params.multiplier = 3.0
    params.tp150      = 3.5
    params.tp300      = 4.0
    params.azuretp    = 4.25
    params.duppercap  = 83
    params.str_wsc    = 0.3
    params.dex_wsc    = 0.0
    params.vit_wsc    = 0.0
    params.agi_wsc    = 0.0
    params.int_wsc    = 0.0
    params.mnd_wsc    = 0.3
    params.chr_wsc    = 0.0

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage <= 0 then
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
