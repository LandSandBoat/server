-----------------------------------
-- Xenoglossia
--
-- Description: Prepares next spell for instant casting.
-- Type: Enhancing
-- Notes: Only used by notorious monsters.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:addMod(xi.mod.UFASTCAST, 150)
    mob:addListener('MAGIC_START', 'XENOGLOSSIA_MAGIC_START', function(user)
        user:delMod(xi.mod.UFASTCAST, 150)
        user:removeListener('XENOGLOSSIA_MAGIC_START')
    end)

    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
