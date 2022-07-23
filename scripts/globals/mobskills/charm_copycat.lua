-----------------------------------
-- Charm Copycat
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0
    local job = target:getMainJob()
    local pos = mob:getPos()
    local id = mob:getID()

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 30)

    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end

    if job == 9 then -- BST
        GetMobByID(id+2):setSpawn(pos.x, pos.y, pos.z, pos.rot)
        SpawnMob(id+2)
    elseif job == 14 then -- DRG
        GetMobByID(id+3):setSpawn(pos.x, pos.y, pos.z, pos.rot)
        SpawnMob(id+3)
    elseif job == 15 then -- SMN
        GetMobByID(id+4):setSpawn(pos.x, pos.y, pos.z, pos.rot)
        SpawnMob(id+4)
    elseif job == 18 then -- PUP
        GetMobByID(id+5):setSpawn(pos.x, pos.y, pos.z, pos.rot)
        SpawnMob(id+5)
    end

    skill:setMsg(msg)

    return typeEffect
end

return mobskill_object
