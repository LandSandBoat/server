-----------------------------------
-- Eald2 Warp Out
-- End Eald'Narche ZM16 (phase 2) teleport
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local battletarget = mob:getTarget()
    local t = battletarget:getPos()
    t.rot = battletarget:getRotPos()
    local angle = math.random() * math.pi
    local pos = NearLocation(t, 1.5, angle)
    mob:teleport(pos, battletarget)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
