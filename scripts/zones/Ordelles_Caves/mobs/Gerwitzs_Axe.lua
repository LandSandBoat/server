-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Axe
-- Involved In Quest: Dark Puppet
-- !pos -51 0.1 3 193
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("darkPuppetCS") >= 2 then
        player:setCharVar("darkPuppetCS", 3)
    end
end

return entity
