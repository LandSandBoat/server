-----------------------------------
-- Area: Ve'Lugannon Palace
--   NM: Steam Cleaner
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    SetServerVariable('[POP]SteamCleaner', os.time() + math.random(7200, 14400))
end

return entity
