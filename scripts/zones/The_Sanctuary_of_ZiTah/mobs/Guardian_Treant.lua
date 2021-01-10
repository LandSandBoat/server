-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Guardian Treant
-- Involved in Quest: Forge Your Destiny
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:setCharVar("ForgeYourDestiny_killed", 1)
end

return entity
