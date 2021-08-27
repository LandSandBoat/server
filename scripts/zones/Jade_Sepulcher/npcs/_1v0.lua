-----------------------------------
-- Area: Jade Sepulcher
--  NPC: Ornamental Door
-- Involved in Missions: TOAU-29
-- !pos 299 0 -199 67
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == xi.mission.id.toau.PUPPET_IN_PERIL and player:getCharVar("AhtUrganStatus") == 0 then
        player:startEvent(4)
    elseif EventTriggerBCNM(player, npc) then
        return
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:setCharVar("AhtUrganStatus", 1)
    elseif EventFinishBCNM(player, csid, option) then
        return
    end
end

return entity
