-----------------------------------
-- Area: Nyzul Isle (Nashmeira's Plea)
--  Mob: Razfahd
-----------------------------------
require('scripts/zones/Nyzul_Isle/IDs')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Wiki is wrong, he CAN melee: https://youtu.be/5ko8xHiHvYo?t=14m31s
    -- mob:setAutoAttackEnabled(false)
    mob:setUnkillable(true)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobFight = function(mob, target)
    -- local warp = mob:getLocalVar("warp")
    if mob:getHPP() <= 50 and mob:getLocalVar("perfectdef") == 0 then
        mob:useMobAbility(1183)

        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)

        mob:setLocalVar("perfectdef", 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
