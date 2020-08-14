-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Iriz Ima
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("BreakChance", 5)
end

function onCriticalHit(mob, attacker)
    if math.random(100) <= mob:getLocalVar("BreakChance") then
        local animationSub = mob:AnimationSub()
        if animationSub == 4 then
            mob:AnimationSub(1) -- 1 horn broken
        elseif animationSub == 1 then
            mob:AnimationSub(2) -- both horns broken
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
