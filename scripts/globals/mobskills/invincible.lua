-----------------------------------
-- Invincible
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 30

    -- Hotupuku ENM: Bugard in the Clouds
    if mob:getPool() == 1992 then
        duration = 900
    end

    xi.mobskills.mobBuffMove(mob, xi.effect.INVINCIBLE, 1, 0, duration)

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.INVINCIBLE
end

return mobskillObject
