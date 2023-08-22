-----------------------------------
--  Formation Attack
--
--  Description: Deals damage to a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 6  then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3 -- should be number of bombs left
    local accmod = 1
    local bombNum = 2 -- Base FTP

    if mob:getAnimationSub() == 4 then
        bombNum = bombNum + 3
    elseif mob:getAnimationSub() == 5 then
        bombNum = bombNum + 2
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, bombNum, bombNum, bombNum)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
