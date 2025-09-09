-----------------------------------
-- Eald2 Warp Out
-- End Eald'Narche ZM16 (phase 2) teleport
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local battletarget = mob:getTarget()
    if not battletarget then
        return
    end

    local t = battletarget:getPos()
    t.rot = battletarget:getRotPos()
    local angle = math.pi * math.random(0, 100) / 100
    local pos = NearLocation(t, 1.5, angle)
    mob:teleport(pos, battletarget)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
