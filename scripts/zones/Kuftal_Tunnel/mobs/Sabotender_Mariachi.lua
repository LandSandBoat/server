-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Sabotender Mariachi
-----------------------------------
---@type TMobEntity
local entity = {}

-- 1% per tick regen during the day
local mobRegen = function(mob)
    local hour = VanadielHour()
    if hour >= 6 and hour < 18 then
        mob:setMod(xi.mod.REGEN, 80)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 15000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 15000)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobRoam = function(mob)
    mobRegen(mob)
end

entity.onMobFight = function(mob, target)
    mobRegen(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 417)
end

return entity
