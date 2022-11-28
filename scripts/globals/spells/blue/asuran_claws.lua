-----------------------------------
-- Spell: Asuran Claws
-- Delivers a sixfold attack. Accuracy varies with TP
-- Spell cost: 81 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: AGI +3
-- Level: 70
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Skillchain Element(s): Fire (Primary) and Lightning (Secondary) - (can open Scission, Detonation, Liquefaction, or Fusion can close Liquefaction, Impaction, or Fusion)
-- Combos: Counter
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    -- Data from https://www.bg-wiki.com/ffxi/Asuran_Claws
    -- D seems low, but the spell was never that great, so a low D is a good way of keeping overall damage down.
        params.tpmod = TPMOD_ACC
        params.attackType = xi.attackType.PHYSICAL
        params.damageType = xi.damageType.HTH
        params.scattr = SC_IMPACTION
        params.numhits = 6
        params.multiplier = 0.625
        params.tp150 = 0.625
        params.tp300 = 0.625
        params.azuretp = 0.625
        params.duppercap = 21
        params.str_wsc = 0.1
        params.dex_wsc = 0.1
        params.vit_wsc = 0.0
        params.agi_wsc = 0.0
        params.int_wsc = 0.0
        params.mnd_wsc = 0.0
        params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spellObject
