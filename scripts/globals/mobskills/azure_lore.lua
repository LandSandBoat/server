-----------------------------------
-- Azure Lore
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
    MobBuffMove(mob, tpz.effect.AZURE_LORE, 1, 0, 45)

    skill:setMsg(tpz.msg.basic.USES)

    return tpz.effect.AZURE_LORE
end

return mobskill_object
