-----------------------------------
-- Trance (Mob Skill)
-- Description : While in effect, lowers TP cost of dances and steps to 0.
-- TODO : Research what Trance does for mobs, this is just a blank effect application for now so the ability can be used.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.TRANCE
end

return mobskillObject
