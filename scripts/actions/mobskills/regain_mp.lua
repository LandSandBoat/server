-----------------------------------
-- Dynamis Statue (Regain MP)
--
-- Description: Regain MP for party members within area of effect.
--
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mp = target:getMaxMP() - target:getMP()

    skill:setMsg(xi.msg.basic.AOE_REGAIN_MP)

    target:addMP(mp)

    return mp
end

return mobskillObject
