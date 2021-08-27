-----------------------------------
--  Torrent
--  Description: Removes all Equipment
--  Type: Magical Enfeebling
--  Ignore Shadows, Single target
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    for i = xi.slot.MAIN, xi.slot.BACK do
        target:unequipItem(i)
    end
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
