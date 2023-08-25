-----------------------------------
-- Area: Horlais Peak
--  Mob: Huntfly
-- BCNM: Dropping Like Flies
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("agroTimer", os.time() + math.random(1, 5))
    mob:setLocalVar("fly", 1)
end

entity.onMobFight = function(mob, target)
    local fly = mob:getLocalVar("fly")

    if mob:getLocalVar("agroTimer") < os.time() then
        mob:setLocalVar("agroTimer", os.time() + math.random(1, 5))

        if fly:isAlive() then
            fly:updateEnmity(target)
        end

        if fly == 8 then
            mob:setLocalVar("fly", 1)
        else
            mob:setLocalVar("fly", fly + 1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
