-----------------------------------
-- Pod Ejection
-- Family: Biotechnological Weapons
-- Description: Spawns a Gunpod
-- Type: Summoning
-- Range: Self
-- Notes: Used only by Proto-Omega whenever he switches forms for the first time or during final form.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:timer(3000, function(mobArg)
        if mobArg:isAlive() then
            local gunpod = GetMobByID(mobArg:getID() + 1)
            if gunpod then
                gunpod:setSpawn(mobArg:getXPos(), mobArg:getYPos(), mobArg:getZPos(), mobArg:getRotPos())
                gunpod:spawn()
                gunpod:updateEnmity(utils.randomEntry(mobArg:getBattlefield():getPlayers()))
            end
        end
    end)

    skill:setMsg(0)
    return 0
end

return mobskillObject
