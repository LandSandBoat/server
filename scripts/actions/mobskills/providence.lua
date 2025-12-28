-----------------------------------
-- Providence
-- Description: Grants additional spells.
-- Type: Self
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
    -- Ensure Poroggo can't use Providence twice in between casts.
    mob:setLocalVar('providence', 1)

    -- Capture existing spell list ID and change the Poroggo to the Providence spell list.
    mob:setLocalVar('[providence]spellListId', mob:getSpellListId())
    mob:setLocalVar('[providence]magicCool', mob:getMobMod(xi.mobMod.MAGIC_COOL))
    mob:setSpellList(506)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 0)

    skill:setMsg(xi.msg.basic.USES)

    -- Listener will reset Poroggo to regular state on first cast.
    mob:addListener('MAGIC_START', 'PROVIDENCE_MAGIC_START', function(mobArg, spell, action)
        -- Reset Poroggo to former spell list or default to generic BLM list
        local postProvidenceSpellListId = mobArg:getLocalVar('[providence]spellListId') or 2
        local postProvidenceMagicCool = mobArg:getLocalVar('[providence]magicCool') or 35

        mobArg:setMobMod(xi.mobMod.MAGIC_COOL, postProvidenceMagicCool)
        mobArg:setSpellList(postProvidenceSpellListId)

        -- Providence is only good for one cast!
        mobArg:removeListener('PROVIDENCE_MAGIC_START')
        mobArg:setLocalVar('providence', 0)
    end)

    return 0
end

return mobskillObject
