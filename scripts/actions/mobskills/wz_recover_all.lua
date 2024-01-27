-----------------------------------
-- Recover All (Armoury Crate)
-- Family: Armoury Crate
-- Description: Recovers all players in an area of effect.
-- Utsusemi/Blink absorb: N/A
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local recoverHP = target:getMaxHP() - target:getHP()
    local recoverMP = target:getMaxMP() - target:getMP()
    target:addHP(recoverHP)
    target:addMP(recoverMP)
    target:resetRecasts()
    skill:setMsg(xi.msg.basic.RECOVERS_HP_AND_MP)
    return 0
end

return mobskillObject
