-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Procreator
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.LINK_RADIUS, 50)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("maxBabies", 4)
end

entity.onMobEngaged = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() - 1) --Agonizer aggros at <20%
        if not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local momma = mob:getID()
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
end

return entity
