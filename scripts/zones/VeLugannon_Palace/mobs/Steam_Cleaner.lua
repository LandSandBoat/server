-----------------------------------
-- Area: Ve'Lugannon Palace
--   NM: Steam Cleaner
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    local respawn = math.random(7200, 14400) -- 2 to 4 hours
    SetServerVariable("[POP]Steam_Cleaner", os.time() + respawn)
end

return entity