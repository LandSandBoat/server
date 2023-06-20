-----------------------------------
-- Chainspell
-- Meant for Qn'aern (RDM) with Ix'Aern encounter
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() == 3269 and mob:getHPP() <= 70 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHAINSPELL
    xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60)

    skill:setMsg(xi.msg.basic.USES)
    return typeEffect
end

return mobskillObject
