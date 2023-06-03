-----------------------------------
-- Mind Wall
-- Description: Activates a shield to absorb all incoming magical damage.
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 3 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 3, 0, 30)
    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
