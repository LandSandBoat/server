-----------------------------------
-- Trample: Charges forward, dealing high damage to,(400-1000) and lowering the MP (10-30%) of, anyone in his path.
-- No message is displayed in the chat log.
--
-- This move is triggered during onMobFight and is only advertised by the fact that DI runs towards random players in range
--
-- When Dark Ixion's HP is low, he can do up to 3 Tramples in succession.
--     Can be avoided easily by moving out of its path.
--     May charge in the opposite, or an entirely random, direction from the one he is currently facing.
--     Will load a set number of targets in his path before ramming forward. Occasionally,
--     a person in his path will not be hit, as well as those wandering in its path after it has begun its charge.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local remainingMPP = 1 - math.random(10, 30) / 100

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod)
    local dmg = 0
    if info.hitslanded > 0 then
        dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
        target:setMP(target:getMP() * remainingMPP)
        skill:setMsg(xi.msg.basic.HIT_DMG)
    else
        skill:setMsg(xi.msg.basic.EVADES)
        return
    end

    return dmg
end

return mobskillObject
