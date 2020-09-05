---------------------------------------------
-- Activate
-- Call automaton.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:hasPet() or mob:getPet() == nil) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    mob:spawnPet()

    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end
