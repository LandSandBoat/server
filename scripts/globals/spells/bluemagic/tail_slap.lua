-----------------------------------------
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
-- Skillchain Element: Water (can open Impaction and Induration can close Reverberation and Fragmentation)
-- Combos: Store TP
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_ATTACK
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.HTH
    params.scattr = SC_REVERBERATION
    params.numhits = 1
    params.multiplier = 1.625
    params.tp150 = 1.625
    params.tp300 = 1.625
    params.azuretp = 1.625
    params.duppercap = 75
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.5
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if (resist > 0.5) then -- This line may need adjusting for retail accuracy.
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 5 * resist) -- pre-resist duration needs confirmed/adjusted
    end

    return damage
end
