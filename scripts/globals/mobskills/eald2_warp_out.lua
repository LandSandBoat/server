-----------------------------------
-- Eald2 Warp Out
-- End Eald'Narche ZM16 (phase 2) teleport
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local battletarget = mob:getTarget()
    local t = battletarget:getPos()
    t.rot = battletarget:getRotPos()
    local angle = math.random() * math.pi
    local dist = 1.5
    if mob:getZoneID() == xi.zone.EMPYREAL_PARADOX then
        dist = math.random(1.5, 10) -- Eald'narche in Empyreal Paradox should teleport up to roughly 10' away as shown in captures/videos. (Apoc Nigh)
    end
    local pos = NearLocation(t, dist, angle)
    mob:teleport(pos, battletarget)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
