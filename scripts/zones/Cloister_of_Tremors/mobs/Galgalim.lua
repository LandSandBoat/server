-----------------------------------
-- Area: Cloister of Tremors
--  Mob: Galgalim
-- Involved in Quest: The Puppet Master
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)

    player:setCharVar("BCNM_Killed", 1)
    record = 300
    partyMembers = 6
    pZone = player:getZoneID()

    player:startEvent(32001, 0, record, 0, (os.time() - player:getCharVar("BCNM_Timer")), partyMembers, 0, 0)

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
