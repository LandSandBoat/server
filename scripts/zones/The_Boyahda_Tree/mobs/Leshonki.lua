-----------------------------------
-- Area: The Boyahda Tree
--   NM: Leshonki
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

local updateRegen = function(mob)
    local hour = VanadielHour()
    if hour >= 6 and hour < 18 then
        mob:setMod(xi.mod.REGEN, 25)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobSpawn = function(mob)
    updateRegen(mob)
end

entity.onMobFight = function(mob)
    updateRegen(mob)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 360)
end

return entity
