-----------------------------------
-- White Wind
--
-- Description:
-- HP recovery on all nearby mobs centered on the user.
-- The higher the user's HP, the higher the HP recovery.
-- Only used by certain puks.
--
-- Player Blue Magic Version uses MaxHP instead of current HP: floor(MaxHP/7)*2
-- The math for mob version is the same but uses current HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return mob:getLocalVar('UsedWhiteWind')
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
    return xi.mobskills.mobHealMove(mob, math.floor(mob:getHP() / 7) * 2)
end

return mobskillObject
