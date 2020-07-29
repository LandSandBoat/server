-----------------------------------
-- Area: Arrapago Reef
--  NPC: Meyaada
-- Type: Assault
-- !pos 22.446 -7.920 573.390 54
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
local ID = require("scripts/zones/Arrapago_Reef/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local toauMission = player:getCurrentMission(TOAU)
    local beginnings = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.BEGINNINGS)

    -- IMMORTAL SENTRIES
    if (toauMission == tpz.mission.id.toau.IMMORTAL_SENTRIES) then
        if (player:hasKeyItem(tpz.ki.SUPPLIES_PACKAGE)) then
            player:startEvent(5)
        elseif (player:getCharVar("AhtUrganStatus") == 1) then
            player:startEvent(6)
        end

    -- BEGINNINGS
    elseif (beginnings == QUEST_ACCEPTED) then
        if (not player:hasKeyItem(tpz.ki.BRAND_OF_THE_SPRINGSERPENT)) then
            player:startEvent(10) -- brands you
        else
            player:startEvent(11) -- a harsh road lies before you
        end

    -- ASSAULT --
    elseif (toauMission >= tpz.mission.id.toau.PRESIDENT_SALAHEEM) then
        local IPpoint = player:getCurrency("imperial_standing")
        if (player:hasKeyItem(tpz.ki.ILRUSI_ASSAULT_ORDERS) and player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) == false) then
            player:startEvent(223, 50, IPpoint)
        else
            player:startEvent(7)
            -- player:delKeyItem(tpz.ki.ASSAULT_ARMBAND)
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(4)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- IMMORTAL SENTRIES
    if (csid == 5 and option == 1) then
        player:delKeyItem(tpz.ki.SUPPLIES_PACKAGE)
        player:setCharVar("AhtUrganStatus", 1)

    -- BEGINNINGS
    elseif (csid == 10) then
        player:addKeyItem(tpz.ki.BRAND_OF_THE_SPRINGSERPENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BRAND_OF_THE_SPRINGSERPENT)

    -- ASSAULT --
    elseif (csid == 223 and option == 1) then
        player:delCurrency("imperial_standing", 50)
        player:addKeyItem(tpz.ki.ASSAULT_ARMBAND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ASSAULT_ARMBAND)
    end
end
