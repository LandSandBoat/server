-----------------------------------
-- Providence
-- Description: Grants additional spells.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('providence') == 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar('providence', 1)
    mob:setSpellList(506)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 0)

    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
