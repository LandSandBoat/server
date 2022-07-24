-----------------------------------
-- Spell: Uproot
-- Deals light damage to enemies within range. Also removes status ailments from caster.
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.LIGHT
    params.multiplier = 4.0
    params.tMultiplier = 2.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.4
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local removables =
    {
        xi.effect.FLASH,
        xi.effect.BLINDNESS,
        xi.effect.PARALYSIS,
        xi.effect.POISON,
        xi.effect.CURSE_I,
        xi.effect.CURSE_II,
        xi.effect.DISEASE,
        xi.effect.PLAGUE,
        xi.effect.FLASH,
        xi.effect.BLINDNESS,
        xi.effect.PARALYSIS,
        xi.effect.POISON,
        xi.effect.CURSE_I,
        xi.effect.CURSE_II,
        xi.effect.DISEASE,
        xi.effect.PLAGUE,
        xi.effect.WEIGHT,
        xi.effect.BIND,
        xi.effect.BIO,
        xi.effect.DIA,
        xi.effect.BURN,
        xi.effect.FROST,
        xi.effect.CHOKE,
        xi.effect.RASP,
        xi.effect.SHOCK,
        xi.effect.DROWN,
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,
        xi.effect.ADDLE,
        xi.effect.SLOW,
        xi.effect.HELIX,
        xi.effect.ACCURACY_DOWN,
        xi.effect.ATTACK_DOWN,
        xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN,
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_ATK_DOWN,
        xi.effect.MAGIC_EVASION_DOWN,
        xi.effect.MAGIC_DEF_DOWN,
        xi.effect.MAX_TP_DOWN,
        xi.effect.MAX_MP_DOWN,
        xi.effect.MAX_HP_DOWN
    }

    for i, effect in ipairs(removables) do
        if (caster:hasStatusEffect(effect)) then
            caster:delStatusEffect(effect)
        end
    end

    return damage
end

return spell_object
