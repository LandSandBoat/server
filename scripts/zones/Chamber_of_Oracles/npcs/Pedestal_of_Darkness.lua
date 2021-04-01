-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Pedestal of Dark
-- Involved in Zilart Mission 7
-- !pos 199 -2 36 168
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ZilartStatus = player:getCharVar("ZilartStatus")

    if (player:getCurrentMission(ZILART) == xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES) then
        if (player:hasKeyItem(xi.ki.DARK_FRAGMENT)) then
            player:delKeyItem(xi.ki.DARK_FRAGMENT)
            player:setCharVar("ZilartStatus", ZilartStatus + 2)
            player:messageSpecial(ID.text.YOU_PLACE_THE, xi.ki.DARK_FRAGMENT)

            if (ZilartStatus == 255) then
                player:startEvent(1)
            end
        elseif (ZilartStatus == 255) then -- Execute cutscene if the player is interrupted.
            player:startEvent(1)
        else
            player:messageSpecial(ID.text.IS_SET_IN_THE_PEDESTAL, xi.ki.DARK_FRAGMENT)
        end
    elseif (player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES)) then
        player:messageSpecial(ID.text.HAS_LOST_ITS_POWER, xi.ki.DARK_FRAGMENT)
    else
        player:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL)
    end

end

entity.onEventUpdate = function(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 1) then
        player:addTitle(xi.title.LIGHTWEAVER)
        player:setCharVar("ZilartStatus", 0)
        player:addKeyItem(xi.ki.PRISMATIC_FRAGMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.PRISMATIC_FRAGMENT)
        player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES)
        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)
    end

end

return entity
