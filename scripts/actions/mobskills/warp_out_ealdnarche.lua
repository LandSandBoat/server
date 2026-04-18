-----------------------------------
-- Warp out (Eald'Narche)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local battletarget = mob:getTarget()
    if not battletarget then
        return
    end

    local t = battletarget:getPos()
    t.rot = battletarget:getRotPos()
    local angle = math.random() * math.pi
    local pos = NearLocation(t, 1.5, angle)
    mob:teleport(pos, battletarget)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
