---------------------------------------------
-- Perdition
-- Description: Instant K.O.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if
        target:isUndead() or
        target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) or
        -- Todo: DeathRes has no place in the resistance functions so far..
        target:getMod(tpz.mod.DEATHRES) > math.random(100)
    then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    skill:setMsg(tpz.msg.basic.FALL_TO_GROUND)
    target:setHP(0)

    return 0
end
