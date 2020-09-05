-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Pedestal of Fire
-- Involved in Zilart Mission 7
-- !pos 199 -2 36 168
-------------------------------------
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
-------------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ZilartStatus = player:getCharVar("ZilartStatus")

    if (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_CHAMBER_OF_ORACLES) then
        if (player:hasKeyItem(tpz.ki.FIRE_FRAGMENT)) then
            player:delKeyItem(tpz.ki.FIRE_FRAGMENT)
            player:setCharVar("ZilartStatus", ZilartStatus + 1)
            player:messageSpecial(ID.text.YOU_PLACE_THE, tpz.ki.FIRE_FRAGMENT)

            if (ZilartStatus == 255) then
                player:startEvent(1)
            end
        elseif (ZilartStatus == 255) then -- Execute cutscene if the player is interrupted.
            player:startEvent(1)
        else
            player:messageSpecial(ID.text.IS_SET_IN_THE_PEDESTAL, tpz.ki.FIRE_FRAGMENT)
        end
    elseif (player:hasCompletedMission(ZILART, tpz.mission.id.zilart.THE_CHAMBER_OF_ORACLES)) then
        player:messageSpecial(ID.text.HAS_LOST_ITS_POWER, tpz.ki.FIRE_FRAGMENT)
    else
        player:messageSpecial(ID.text.PLACED_INTO_THE_PEDESTAL)
    end

end

function onEventUpdate(player, csid, option)
    -- printf("onUpdate CSID: %u", csid)
    -- printf("onUpdate RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("onFinish CSID: %u", csid)
    -- printf("onFinish RESULT: %u", option)

    if (csid == 1) then
        player:addTitle(tpz.title.LIGHTWEAVER)
        player:setCharVar("ZilartStatus", 0)
        player:addKeyItem(tpz.ki.PRISMATIC_FRAGMENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PRISMATIC_FRAGMENT)
        player:completeMission(ZILART, tpz.mission.id.zilart.THE_CHAMBER_OF_ORACLES)
        player:addMission(ZILART, tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)
    end

end
