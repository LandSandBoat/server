-----------------------------------
-- Perdition
-- Description: Instant K.O.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if
        target:isUndead() or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD) or
        -- Todo: DeathRes has no place in the resistance functions so far..
        target:getMod(xi.mod.DEATHRES) > math.random(100)
    then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    skill:setMsg(xi.msg.basic.FALL_TO_GROUND)
    target:setHP(0)

    return 0
end

return mobskill_object
