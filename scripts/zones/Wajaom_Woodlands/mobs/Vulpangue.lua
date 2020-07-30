-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Vulpangue
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/weather")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mod:addMod((tpz.mod.FIRE_ABSORB + VanadielDayElement()), 100)
    mob:addMod(tpz.mod.WIND_ABSORB, 100)
    mob:setLocalVar("HPP", 90)
end

function onMobFight(mob, target)
    local defUpHPP = mob:getLocalVar("HPP")
    if mob:getHPP() <= defUpHPP then
        if mob:getHPP() > 10 then
            mob:addMod(tpz.mod.ACC, 10)
            mob:addMod(tpz.mod.ATT, 10)
            mob:setLocalVar("HPP", mob:getHPP() - 10)
        end
    end
end

function onMobDeath(mob, killer)
end
