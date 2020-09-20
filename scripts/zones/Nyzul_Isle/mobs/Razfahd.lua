-----------------------------------
-- Area: Nyzul Isle (Nashmeira's Plea)
--  Mob: Razfahd
-----------------------------------
require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobSpawn(mob)
    -- Wiki is wrong, he CAN melee: https://youtu.be/5ko8xHiHvYo?t=14m31s
    -- mob:SetAutoAttackEnabled(false)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
    local warp = mob:getLocalVar("warp")

    if (mob:getHPP() <= 50 and mob:getLocalVar("perfectdef") == 0) then
        mob:useMobAbility(1183)

        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)

        mob:setLocalVar("perfectdef", 1)
    end
end

function onMobDeath(mob, player, isKiller)
end
