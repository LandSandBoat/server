-----------------------------------
-- Vampiric Lash
--
-- Description: Deals dark damage to a single target. Additional effect: Drain
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Notes: In ToAU zones, this has an additional effect of absorbing all status effects, including food.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    if mob:getLocalVar("vampiriclashpower") ~= 0 then
        dmgmod = mob:getLocalVar("vampiriclashpower")
    end
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)
    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    return dmg
end

return mobskillObject
