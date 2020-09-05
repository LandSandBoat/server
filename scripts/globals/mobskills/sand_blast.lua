---------------------------------------------
-- Sand Blast
-- Deals Earth damage to targets in a fan-shaped area of effect. Additional effect: Blind
-- Range: 8' cone
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BLINDNESS
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 20, 0, 120))

    if (mob:getPool() == 1318 and mob:getLocalVar("SAND_BLAST") == 1) then -- Feeler Anltion
        local alastorId = mob:getID()+6
        local alastor = GetMobByID(alastorId)
        if (not alastor:isSpawned()) then -- Alastor Antlion
            mob:setLocalVar("SAND_BLAST", 0) -- Don't spawn more NMs
            alastor:setSpawn(mob:getXPos() + 1, mob:getYPos() + 1, mob:getZPos() + 1) -- Set its spawn location.
            SpawnMob(alastorId, 120):updateClaim(target)
        end
    end

    return typeEffect
end
