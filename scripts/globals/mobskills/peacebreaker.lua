-----------------------------------
-- Peacebreaker
-- Description: Deals damage and increases magic damage taken by target
-- Peacebreaker increases Magic Damage Taken on the target (~2x Magic Damage),
-- making Naja a good fit with offensive magic jobs such as Rune Fencer.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    -- TODO: This should be Increases Magic Damage Taken, but this was faster/easier
    MobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, 50, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
