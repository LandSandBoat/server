-----------------------------------
-- Area: The Boyahda Tree
--   NM: Leshonki
--   Has strong regen during the day, despawns at night
-----------------------------------
---@type TMobEntity
local entity = {}

local mobRegen = function(mob)
    local hour = VanadielHour()
    if hour >= 6 and hour < 18 then
        mob:setMod(xi.mod.REGEN, 160)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobRoam = function(mob)
    mobRegen(mob)

    local totd = VanadielTOTD()
    if totd == xi.time.NIGHT and totd == xi.time.MIDNIGHT then
        mob:setLocalVar('doNotInvokeCooldown', 1)
        DespawnMob(mob:getID())
    end
end

entity.onMobFight = function(mob, target)
    mobRegen(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 360)
end

return entity
