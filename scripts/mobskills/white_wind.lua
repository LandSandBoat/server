-----------------------------------
-- White Wind
--
-- Description:
-- HP recovery on all nearby mobs centered on the user.
-- The higher the user's HP, the higher the HP recovery.
-- Only used by certain puks.
--
-- Player Blue Magic Version uses MaxHP instead of current HP: floor(MaxHP/7)*2
-- The math for mob version may be different, it's presumed to be the same here.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    --  TODO: get capture of messages, message may be the following:
    --[[
    if target:getID() == target:getID() then
        spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)
    else
        spell:setMsg(xi.msg.basic.SELF_HEAL_SECONDARY)
    end
    --]]
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)
    -- Todo: verify/correct maths
    return xi.mobskills.mobHealMove(mob, math.floor(mob:getHP() / 7) * 2)
end

return mobskillObject
