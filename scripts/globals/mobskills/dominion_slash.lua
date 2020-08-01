---------------------------------------------
-- Dominion Slash
--
-- Description: Performs an area of effect slashing weaponskill. Additional effect: Silence
-- Type: Physical
-- 2-3 Shadows
-- Range: Unknown radial

-- One source also mentions that it "can dispel important buffs."
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

   -- TODO: Can skillchain?  Unknown property.

    local numhits = 1
    local accmod = 1
    local dmgmod = 3.25
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_2_SHADOW)

    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 60)

    -- Due to conflicting information, making the dispel resistable.  Correct/tweak if wrong.
    -- Dispel has no status effect or resistance gear, so 0s instead of nulls.
    local resist = applyPlayerResistance(mob, 0, target, mob:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), 0, tpz.magic.ele.LIGHT)
    if (resist > 0.0625) then
        target:dispelStatusEffect()
    end

    -- TODO: Dispel message

    -- Damage is HIGHLY conflicting.  Witnessed anywhere from 300 to 900.
    -- TP DMG VARIES can sort of account for this, but I feel like it's still not right.
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
