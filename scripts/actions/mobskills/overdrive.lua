-----------------------------------
-- Overdrive (Mob Skill)
-- Description : Augments the fighting ability of the automaton to its maximum level.
-- TODO : Research what Overdrive does for mobs, this is just a blank effect application for now so the ability can be used.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.OVERDRIVE
end

return mobskillObject
