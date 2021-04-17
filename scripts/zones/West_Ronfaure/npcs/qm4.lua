-----------------------------------
-- Area: West Ronfaure
--  NPC: qm4 (???)
-- Involved in Mission: San d'Orian Mission 7-1 (Prestige of the Papsque)
-- !pos -695 -40 21 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(SANDORIA, xi.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE) and
        player:getMissionStatus(player:getNation()) == 1 and
        not GetMobByID(ID.mob.MARAUDER_DVOGZOG):isSpawned()
    then
        if player:getCharVar("Mission7-1MobKilled") == 1 and player:needToZone() then
            player:addKeyItem(xi.ki.ANCIENT_SANDORIAN_TABLET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ANCIENT_SANDORIAN_TABLET)
            player:setCharVar("Mission7-1MobKilled", 0)
            player:setMissionStatus(player:getNation(), 2)
        else
            SpawnMob(ID.mob.MARAUDER_DVOGZOG):updateClaim(player)
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
