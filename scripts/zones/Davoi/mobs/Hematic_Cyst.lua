-----------------------------------
-- Area: Davoi
-- NM: Hematic Cyst
-- Involved in Quest: Tea with a Tonberry?
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:setCharVar("TEA_WITH_A_TONBERRY_PROG", 4)
end

return entity
