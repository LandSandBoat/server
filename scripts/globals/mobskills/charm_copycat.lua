-----------------------------------
-- Charm Copycat
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 100
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

    local jobs =
    {
        { xi.job.BST, 2 },
        { xi.job.DRG, 3 },
        { xi.job.SMN, 4 },
        { xi.job.PUP, 5 },
    }

    for _, v in pairs(jobs) do
        if job == v[1] then
            GetMobByID(id + v[2]):setSpawn(pos.x, pos.y, pos.z, pos.rot)
            SpawnMob(id + v[2])
            break
        end
    end

    skill:setMsg(msg)

    return typeEffect
end

return mobskillObject
