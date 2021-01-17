-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: ??? Rhapsodies of Vanadiel Mission 1-15 Impurity
-- !pos -409.553 17.356 -380.626 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(ROV) == tpz.mission.id.rov.IMPURITY then
        player:startEvent(212)
    elseif player:getCurrentMission(ROV) == tpz.mission.id.rov.THE_LOST_AVATAR and player:getCharVar("RhapsodiesStatus") == 1 then
        player:startEvent(213)
    elseif player:getCurrentMission(ROV) == tpz.mission.id.rov.THE_LOST_AVATAR then
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        npcUtil.popFromQM(player, npc, ID.mob.SIREN, { look=true, hide=0 })
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 212 then
        player:completeMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.IMPURITY)
        player:addMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.THE_LOST_AVATAR)
    elseif csid == 213 then
        player:setCharVar("RhapsodiesStatus", 0)
        npcUtil.giveKeyItem(player, tpz.ki.RHAPSODY_IN_AZURE)
        player:completeMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.THE_LOST_AVATAR)
        player:addMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.VOLTO_OSCURO)
    end
end
return entity
