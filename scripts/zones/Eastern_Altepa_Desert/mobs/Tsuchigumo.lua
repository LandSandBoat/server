-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Tsuchigumo
-- Involved in Quest: 20 in Pirate Years
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("twentyInPirateYearsCS") == 3 then
        player:addCharVar("TsuchigumoKilled", 1)
    end
end

return entity
