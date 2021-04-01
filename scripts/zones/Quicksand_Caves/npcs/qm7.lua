-----------------------------------
-- Area: Quicksand Caves
--  NPC: ???
-- Involved in Mission: The Mithra and the Crystal (Zilart 12)
-- !pos -504 20 -419 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(ZILART) == xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL and player:getCharVar("ZilartStatus") == 1 and not player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)) then
        if (player:needToZone() and player:getCharVar("AncientVesselKilled") == 1) then
            player:setCharVar("AncientVesselKilled", 0)
            player:addKeyItem(xi.ki.SCRAP_OF_PAPYRUS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SCRAP_OF_PAPYRUS)
        else
            player:startEvent(12)
        end
    elseif (player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL) or player:hasKeyItem(xi.ki.SCRAP_OF_PAPYRUS)) then
        player:messageSpecial(ID.text.YOU_FIND_NOTHING)
    else
        player:messageSpecial(ID.text.SOMETHING_IS_BURIED)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 12 and option == 1) then
        SpawnMob(ID.mob.ANCIENT_VESSEL):updateClaim(player)
    end
end

return entity
