-----------------------------------
-- Biomagnet
-- Only used by Ramparts when its door is closed
-- Description: Draws in a player with biomagnetism.
-- Utsusemi/Blink absorb: Ignores shadows
-- Range 10' single target
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 1 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:timer(3500, function(mobArg)
        if target and target:getHP() > 0 then
            local pos = mobArg:getPos()

            if mobArg:isAlive() then
                target:setPos(pos.x, pos.y, pos.z)
            end
        end
    end)

    skill:setMsg(xi.msg.basic.DRAWN_IN)

    return 0
end

return mobskillObject
