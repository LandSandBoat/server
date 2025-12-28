-----------------------------------
-- Tabula Rasa (Mob Skill)
-- Description : Optimizes both white and black magic capabilities while allowing charge-free stratagem use.
-- TODO : Research what Tabula Rasa does for mobs, this is just a blank effect application for now so the ability can be used.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.TABULA_RASA
end

return mobskillObject
