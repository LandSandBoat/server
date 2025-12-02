-----------------------------------
-- Trample: Charges forward, dealing high damage to,(400-1000) and lowering the MP (10-30%) of, anyone in his path.
-- No message is displayed in the chat log.
-- Video showing 25% mp lost on hit: https://youtu.be/Jj9pWfSr1c0?t=26
--
-- This move is triggered during onMobFight and is only advertised by the fact that DI runs towards random players in range and has dust under his feet
--
-- When Dark Ixion's HP is low, he can do up to 3 Tramples in succession.
--     Can be avoided easily by moving out of its path.
--     May charge in the opposite, or an entirely random, direction from the one he is currently facing.
--     Will load a set number of targets in his path before ramming forward.
--     Occasionally, a person in his path will not be hit, as well as those wandering in its path after it has begun its charge.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- perform physical attack
    local numhits = 1
    local accmod  = 1
    local ftp     = 3
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    -- if skill hit, apply dmg and reduce MP
    if not skill:hasMissMsg() then
        local remainingMPP = 1 - math.random(10, 30) / 100

        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
        target:setMP(target:getMP() * remainingMPP)
        skill:setMsg(xi.msg.basic.HIT_DMG)
    elseif dmg == 0 then
        -- basic miss (not shadows or anticipation)
        skill:setMsg(xi.msg.basic.EVADES)
    end

    return dmg
end

return mobskillObject
