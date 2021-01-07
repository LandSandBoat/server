-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Soul
-- Involved In Quest: Dark Puppet
-- !pos -51 0.1 3 193
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("darkPuppetCS") >= 4 then
        player:setCharVar("darkPuppetCS", 5)
    end
end

return entity
