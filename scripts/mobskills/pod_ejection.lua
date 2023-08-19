-----------------------------------
-- Pod Ejection
-- Family: Biotechnological Weapons
-- Description: Spawns a Gunpod
-- Type: Summoning
-- Range: Self
-- Notes: Used only by Proto-Omega whenever he switches forms for the first time or during final form.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:timer(3000, function(mobArg)
        if mob:isAlive() then
            local gunpod = GetMobByID(mob:getID() + 1)
            gunpod:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
            gunpod:spawn()
            gunpod:updateEnmity(utils.randomEntry(mob:getBattlefield():getPlayers()))
        end
    end)

    skill:setMsg(0)
    return 0
end

return mobskillObject
