-----------------------------------
-- Area: Caedarva Mire
--  NPC: Nahshib
-- Type: Assault
-- !pos -274.334 -9.287 -64.255 79
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
local ID = require("scripts/zones/Caedarva_Mire/IDs")
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

    -- SHADES OF VENGEANCE
    elseif (toauMission == tpz.mission.id.toau.SHADES_OF_VENGEANCE and player:hasKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT) == false and vanaDay() > player:getCharVar("TOAUM31_PERMITDAY")) then
        player:startEvent(22)

    -- BEGINNINGS
    elseif (beginnings == QUEST_ACCEPTED) then
        if (not player:hasKeyItem(tpz.ki.BRAND_OF_THE_GALESERPENT)) then
            player:startEvent(10) -- brands you
        else
            player:startEvent(11) -- so now i am the teacher?
        end

    -- ASSAULT
    elseif (toauMission >= tpz.mission.id.toau.PRESIDENT_SALAHEEM) then
        local IPpoint = player:getCurrency("imperial_standing")
        if (player:hasKeyItem(tpz.ki.PERIQIA_ASSAULT_ORDERS) and player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) == false) then
            player:startEvent(148, 50, IPpoint)
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

    -- SHADES OF VENGEANCE
    elseif (csid == 22) then
        player:setCharVar("TOAUM31_PERMITDAY", vanaDay())
        player:addKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)

    -- BEGINNINGS
    elseif (csid == 10) then
        player:addKeyItem(tpz.ki.BRAND_OF_THE_GALESERPENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BRAND_OF_THE_GALESERPENT)

    -- ASSAULT
    elseif (csid == 148 and option == 1) then
        player:delCurrency("imperial_standing", 50)
        player:addKeyItem(tpz.ki.ASSAULT_ARMBAND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ASSAULT_ARMBAND)
    end
end
