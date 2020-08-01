---------------------------------------------
--  Pit Ambush
--
--  Description: Only used by black antlions when they emerge to attack a player overhead.
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getPool() == 1318 and mob:getLocalVar("AMBUSH") == 1) then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, MOBPARAM_WIPE_SHADOWS)

    -- These are here as it doesn't look right otherwise
    mob:hideName(false)
    mob:untargetable(false)
    mob:AnimationSub(1)
    mob:setLocalVar("AMBUSH", 1) -- Used it for the last time!

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
