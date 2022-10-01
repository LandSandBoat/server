-----------------------------------
-- Area: Gustav Tunnel
--   NM: Gigaplasm
-- Note: Part of mission "The Salt of the Earth"
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        local mobId = mob:getID()
        local x = mob:getXPos()
        local y = mob:getYPos()
        local z = mob:getZPos()

        SpawnMob(mobId + 1):setPos(x, y, z)
        SpawnMob(mobId + 2):setPos(x-1, y, z-1)
        GetMobByID(mobId + 1):updateEnmity(player)
        GetMobByID(mobId + 2):updateEnmity(player)
    end
end

return entity
