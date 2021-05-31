-----------------------------------
-- Tarutaru Warp II
-- End Ark Angel TT teleport
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local t = mob:getSpawnPos()
    local angle = math.random() * 2 * math.pi
    local pos = NearLocation(t, 18.0, angle)
    mob:teleport(pos, target)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
