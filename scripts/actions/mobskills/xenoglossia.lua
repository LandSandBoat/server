-----------------------------------
-- Xenoglossia
--
-- Description: Prepares next spell for instant casting.
-- Type: Enhancing
-- Notes: Only used by notorious monsters.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- TODO: Remove this. This is horrible.
    mob:addMod(xi.mod.UFASTCAST, 150)
    mob:addListener('MAGIC_START', 'XENOGLOSSIA_MAGIC_START', function(mobArg, targetArg, spell, actionArg)
        mobArg:delMod(xi.mod.UFASTCAST, 150)
        mobArg:removeListener('XENOGLOSSIA_MAGIC_START')
    end)

    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
