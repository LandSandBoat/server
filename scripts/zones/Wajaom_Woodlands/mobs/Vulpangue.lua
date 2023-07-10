-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Vulpangue
-----------------------------------
mixins = { require("scripts/mixins/rage") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:addMod((xi.mod.FIRE_ABSORB + VanadielDayElement() - 1), 100)
    mob:addMod(xi.mod.WIND_ABSORB, 100)
    mob:setLocalVar("HPP", 90)
end

entity.onMobFight = function(mob, target)
    local defUpHPP = mob:getLocalVar("HPP")
    if mob:getHPP() <= defUpHPP then
        if mob:getHPP() > 10 then
            mob:addMod(xi.mod.ACC, 10)
            mob:addMod(xi.mod.ATT, 10)
            mob:setLocalVar("HPP", mob:getHPP() - 10)
        end
    end
end

entity.onMobDeath = function(mob, killer)
end

return entity
