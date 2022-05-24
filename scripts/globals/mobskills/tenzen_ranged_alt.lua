---------------------------------------------------
-- Tenzed Ranged Attack Alt
-- Only Used when in Bow Mode
-- Deals a ranged attack to a single target.
---------------------------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/mobskills")
---------------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.5

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numhits, accmod, dmgmod, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)
    local msg = skill:getMsg()
    if
        dmg > 0 and
        msg ~= xi.msg.basic.SHADOW_ABSORB
    then
        target:addTP(20)
        mob:addTP(80)
    end

    if msg ~= xi.msg.basic.SHADOW_ABSORB then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end
    skill:setMsg(352) -- fixes incorrect messages on ranged attacks
    return dmg
end

return mobskill_object
