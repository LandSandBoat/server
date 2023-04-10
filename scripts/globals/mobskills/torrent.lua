-----------------------------------
--  Torrent
--  Description: Removes all Equipment
--  Type: Magical Enfeebling
--  Ignore Shadows, Single target
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    for i = xi.slot.MAIN, xi.slot.BACK do
        target:unequipItem(i)
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
