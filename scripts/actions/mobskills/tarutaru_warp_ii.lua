-----------------------------------
-- Tarutaru Warp II
-- End Ark Angel TT teleport
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local t = mob:getSpawnPos()
    local angle = math.pi * math.random(0, 100) / 100
    local pos = NearLocation(t, 18.0, angle)
    mob:teleport(pos, target)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
