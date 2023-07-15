---------------------------------------------
-- Starlight
--
-- Description: Restores MP (self).
-- Type: Physical
-- Range: Melee
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mpRecoverAmt = mob:getWeaponDmg() * 1.75
    local maxmp = target:getMaxMP()
    local currmp = target:getMP()
    if mpRecoverAmt + currmp > maxmp then
            mpRecoverAmt = maxmp - currmp
        end
    skill:setMsg(xi.msg.basic.RECOVERS_MP, 0, mpRecoverAmt)
end

return mobskillObject
