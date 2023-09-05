-----------------------------------
-- Lateral Slash
-- Dummy ability used for 2hr animation.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == 1507 then -- Geush Urvan
        local typeEffect = xi.effect.COUNTERSTANCE

        xi.mobskills.mobBuffMove(mob, typeEffect, 10, 0, 60)
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    else
        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end
end

return mobskillObject
