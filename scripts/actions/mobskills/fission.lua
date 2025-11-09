-----------------------------------
-- Mob Skill: Fission
-- Description : Summons an empty to assist its user.
-- Note: Requires gorger_nm mixin for mobs to set fissionAdds local var
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mobID = mob:getID()
    local numAdds = mob:getLocalVar('fissionAdds')
    local pets = {}
    for i = 1, numAdds do
        table.insert(pets, mobID + i)
    end

    local petParams =
    {
        maxSpawns = 1,
        noAnimation = true,
        dieWithOwner = true,
        superlink = true,
        ignoreBusy = true,
    }
    xi.mob.callPets(mob, pets, petParams)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
