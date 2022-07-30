-----------------------------------
-- Mobskill: Counterstance
-- Increases chance to counter but lowers defense.
--  used by The Waughroon Kid in BCNM The Final Bout.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(mob, target, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(mob, target, skill)
    local power = 45 + mob:getMod(xi.mod.COUNTERSTANCE_EFFECT)

    mob:delStatusEffect(xi.effect.COUNTERSTANCE) --if not found this will do nothing
    mob:addStatusEffect(xi.effect.COUNTERSTANCE, power)

    skill:setMsg(xi.msg.basic.USES)
end

return mobskill_object
