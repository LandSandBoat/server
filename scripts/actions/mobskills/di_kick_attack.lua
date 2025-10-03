-----------------------------------
-- Dark Ixion basic melee attack with front legs
-- Note: Has basic autoattack-style messages, consumes no TP (and applies ??? effect?)
-- normal tp gain is applied since the skill is used in place of an autoattack
-- TODO does this attack have an AE? other two do but there are no reports of a third AE type, nor have any videos shown an AE coming from the kick attack
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
    local ftp     = 1
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    -- if skill hit, apply dmg and AE
    if not skill:hasMissMsg() then
        skill:setMsg(xi.msg.basic.HIT_DMG)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    elseif dmg == 0 then
        -- basic miss (not shadows or anticipation)
        skill:setMsg(xi.msg.basic.EVADES)
    end

    return dmg
end

return mobskillObject
