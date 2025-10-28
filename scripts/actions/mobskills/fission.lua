-----------------------------------
-- Mob Skill: Fission
-- Description : Summons an empty to assist its user.
-- To expand this list, define the mob in mob_pools.lua and extend the table below.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

local fissionAdds =
{
    [xi.mobPools.HADAL_SATIATOR]  = 3,
    [xi.mobPools.INGESTER]        = 4,
    [xi.mobPools.PROGENERATOR]    = 4,
    [xi.mobPools.DEPTHS_DIGESTER] = 6,
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mobID = mob:getID()
    local numAdds = fissionAdds[mob:getPool()]
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
