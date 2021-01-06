-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Sword
-- Involved In Quest: Dark Puppet
-- !pos -51 0.1 3 193
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("darkPuppetCS") >= 3 then
        player:setCharVar("darkPuppetCS", 4)
    end
end

return entity
