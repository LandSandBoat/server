-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Cumulator
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.LINK_RADIUS, 50)
end

entity.onMobSpawn = function(mob)
end

entity.onMobEngaged = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 20 then
        local nextMob = GetMobByID(mob:getID() - 5) --Procreator aggros at <20%
        if not nextMob:isEngaged() then
            nextMob:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
