---------------------------------------------
--  Tourbillion
--
--  Description: Delivers an area attack. Additional effect duration varies with TP. Additional effect: Weakens defense.
--  Type: Physical
--  Shadow per hit
--  Range: Unknown range
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
  if(mob:getFamily() == 316) then
    local mobSkin = mob:getModelId()

    if (mobSkin == 1805) then
        return 0
    else
        return 1
    end
  end
   --[[TODO: Khimaira should only use this when its wings are up, which is animationsub() == 0.
   There's no system to put them "down" yet, so it's not really fair to leave it active.
   Tyger's fair game, though. :)]]
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    local duration = 20 * (skill:getTP() / 1000)

    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.DEFENSE_DOWN, 20, 0, duration)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
