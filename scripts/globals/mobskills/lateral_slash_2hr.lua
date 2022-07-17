-----------------------------------
-- Lateral Slash
-- Dummy ability used for 2hr animation.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
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

return mobskill_object
