-----------------------------------------
-- Spell: Sudden Lunge
-- Damage varies with TP. Additional effect: "Stun."
-- Spell cost: 18 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5 MP-5 DEX+1 AGI+1
-- Level: 95
-- Casting Time: 0.5 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s):
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
    -- Todo: determine if these param values are retail
    params.tpmod = TPMOD_DAMAGE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_DETONATION
    params.numhits = 1
    params.multiplier = 1.875
    params.tp150 = 1.25
    params.tp300 = 1.50
    params.azuretp = 1.4375
    params.duppercap = 100
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.4
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if (resist > 0.25) then -- This line may need adjusting for retail accuracy.
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 20 * resist) -- Wiki says duration of "up to" 20 second..
    end

    return damage
end
