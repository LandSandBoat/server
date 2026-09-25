-----------------------------------
-- Area: The Boyahda Tree
--   NM: Leshonki
--   Has strong regen during the day, despawns at night
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.LESHONKI - 8] = ID.mob.LESHONKI, -- Confirmed on retail
    [ID.mob.LESHONKI - 6] = ID.mob.LESHONKI, -- Confirmed on retail
    [ID.mob.LESHONKI - 4] = ID.mob.LESHONKI, -- Confirmed on retail
    [ID.mob.LESHONKI + 1] = ID.mob.LESHONKI, -- Confirmed on retail
    [ID.mob.LESHONKI + 4] = ID.mob.LESHONKI, -- Confirmed on retail
}

local mobRegen = function(mob)
    local hour = VanadielHour()
    if hour >= 6 and hour < 18 then
        mob:setMod(xi.mod.REGEN, 160)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobRoam = function(mob)
    mobRegen(mob)

    local totd = VanadielTOTD()
    if totd == xi.time.NIGHT and totd == xi.time.MIDNIGHT then
        mob:setLocalVar('doNotInvokeCooldown', 1)
        DespawnMob(mob:getID())
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobFight = function(mob, target)
    mobRegen(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 360)
end

entity.onMobDespawn = function(mob)
end

return entity
