-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Naja Salaheem
-- Type: Standard NPC
-- !pos 22.700 -8.804 -45.591 50
-----------------------------------
require("scripts/zones/Aht_Urhgan_Whitegate/Shared")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (npcUtil.tradeHas(trade, 2163) and player:getCharVar("PromotionPFC") == 1) then -- Rank to PFC
        player:startEvent(5002, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
end

function onTrigger(player, npc)

    local TOAUM3_DAY = player:getCharVar("TOAUM3_STARTDAY")
    local realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day
    local needToZone = player:needToZone()

    if (player:getCharVar("AssaultPromotion") >= 25 and player:hasKeyItem(tpz.ki.PFC_WILDCAT_BADGE) == false and player:getCharVar("PromotionPFC") == 0) then
        player:startEvent(5000, 0, 0, 0, 0, 0, 0, 0, 0, 0) -- PFC rank is available
    elseif (player:getCharVar("PromotionSP") == 1 and player:hasKeyItem(tpz.ki.DARK_RIDER_HOOFPRINT) == true) then
        player:startEvent(5022, 0, 0, 0, 0, 0, 0, 0, 0, 0) -- Superior Private rank complete
    elseif (player:getCharVar("AssaultPromotion") >= 25 and player:hasKeyItem(tpz.ki.SP_WILDCAT_BADGE) == false and player:getCharVar("PromotionSP") == 0) then
        player:startEvent(5020, 0, 0, 0, 0, 0, 0, 0, 0, 0) -- Superior Private rank is available
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.IMMORTAL_SENTRIES and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(3002, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PRESIDENT_SALAHEEM and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(73, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PRESIDENT_SALAHEEM and player:getCharVar("AhtUrganStatus") == 2 and TOAUM3_DAY ~= realday and needToZone == false) then
        player:startEvent(3020, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.KNIGHT_OF_GOLD and player:getCharVar("AhtUrganStatus") == 0) then
        player:startEvent(3021, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.WESTERLY_WINDS and player:getCharVar("AhtUrganStatus") == 1) then
        player:startEvent(3028, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.UNDERSEA_SCOUTING) then
        player:startEvent(3051, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.ASTRAL_WAVES) then
        player:startEvent(3052, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.IMPERIAL_SCHEMES and player:getCharVar("TOAUM11_STARTDAY") ~= VanadielDayOfTheYear() and needToZone == false) then
        player:startEvent(3070, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.ROYAL_PUPPETEER) then
        player:startEvent(3071, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_DOLPHIN_CREST) then
        player:startEvent(3072, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_BLACK_COFFIN) then
        player:startEvent(3073, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.GHOSTS_OF_THE_PAST) then
        if (doRoyalPalaceArmorCheck(player) == true) then
            player:startEvent(3074, 1, 0, 0, 0, 0, 0, 0, 1, 0)
        else
            player:startEvent(3074, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        end
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.GUESTS_OF_THE_EMPIRE) then
        if (doRoyalPalaceArmorCheck(player) == true) then
            if (player:getCharVar("AhtUrganStatus") == 0) then
                player:startEvent(3076, 1, 0, 0, 0, 0, 0, 0, 1, 0)
            else
                player:startEvent(3077, 1, 0, 0, 0, 0, 0, 0, 1, 0)
            end
        else
            if (player:getCharVar("AhtUrganStatus") == 0) then
                player:startEvent(3076, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            else
                player:startEvent(3077, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            end
        end
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PASSING_GLORY and player:getCharVar("TOAUM18_STARTDAY") ~= VanadielDayOfTheYear() and needToZone == false) then
        player:startEvent(3090, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.IN_THE_BLOOD) then
        player:startEvent(3113, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.SENTINELS_HONOR) then
        if(player:getCharVar("TOAUM18_STARTDAY") ~= VanadielDayOfTheYear() and needToZone == false) then
            player:startEvent(3130, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        else
            player:startEvent(3120, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        end
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.FANGS_OF_THE_LION) then
        player:startEvent(3138, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.NASHMEIRAS_PLEA and player:hasKeyItem(tpz.ki.MYTHRIL_MIRROR) == false) then
        player:startEvent(3149, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.RAGNAROK) then
        player:startEvent(3139, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.IMPERIAL_CORONATION) then
        player:startEvent(3150, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_EMPRESS_CROWNED) then
        player:startEvent(3144, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.ETERNAL_MERCENARY) then
        player:startEvent(3154, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        player:startEvent(3003, 1, 0, 0, 0, 0, 0, 0, 1, 0) -- go back to work

     -- player:messageSpecial(0)--  need to find correct normal chat CS..
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 73) then
        player:setCharVar("AhtUrganStatus", 2)
        player:setCharVar("TOAUM3_DAY", os.date("%j")) -- %M for next minute, %j for next day
    elseif (csid == 3002) then
        player:setCharVar("AhtUrganStatus", 0)
        player:completeMission(TOAU, tpz.mission.id.toau.IMMORTAL_SENTRIES)
        player:addMission(TOAU, tpz.mission.id.toau.PRESIDENT_SALAHEEM)
        player:addCurrency("imperial_standing", 150)
        player:addTitle(tpz.title.PRIVATE_SECOND_CLASS)
        player:addKeyItem(tpz.ki.PSC_WILDCAT_BADGE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PSC_WILDCAT_BADGE)
    elseif (csid == 3020) then
        player:setCharVar("AhtUrganStatus", 0)
        player:completeMission(TOAU, tpz.mission.id.toau.PRESIDENT_SALAHEEM)
        player:addMission(TOAU, tpz.mission.id.toau.KNIGHT_OF_GOLD)
        player:setCharVar("TOAUM3_DAY", 0)
    elseif (csid == 3028) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2185)
        else
            player:addItem(2185, 2)
            player:setCharVar("AhtUrganStatus", 0)
            player:completeMission(TOAU, tpz.mission.id.toau.WESTERLY_WINDS)
            player:addMission(TOAU, tpz.mission.id.toau.A_MERCENARY_LIFE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 2185)
            player:needToZone(true)
        end
    elseif (csid == 3052) then
        player:completeMission(TOAU, tpz.mission.id.toau.ASTRAL_WAVES)
        player:needToZone(true)
        player:setCharVar("TOAUM11_STARTDAY", VanadielDayOfTheYear())
        player:addMission(TOAU, tpz.mission.id.toau.IMPERIAL_SCHEMES)
    elseif (csid == 3070) then
        player:completeMission(TOAU, tpz.mission.id.toau.IMPERIAL_SCHEMES)
        player:setCharVar("TOAUM11_STARTDAY", 0)
        player:addMission(TOAU, tpz.mission.id.toau.ROYAL_PUPPETEER)
    elseif (csid == 3072) then
        player:completeMission(TOAU, tpz.mission.id.toau.THE_DOLPHIN_CREST)
        player:addMission(TOAU, tpz.mission.id.toau.THE_BLACK_COFFIN)
    elseif (csid == 3074) then
        player:completeMission(TOAU, tpz.mission.id.toau.GHOSTS_OF_THE_PAST)
        player:addMission(TOAU, tpz.mission.id.toau.GUESTS_OF_THE_EMPIRE)

        if(option == 2) then
            player:setCharVar("AhtUrganStatus", 1)
        end
    elseif (csid == 3090) then
        player:completeMission(TOAU, tpz.mission.id.toau.PASSING_GLORY)
        player:setCharVar("TOAUM18_STARTDAY", 0)
        player:addMission(TOAU, tpz.mission.id.toau.SWEETS_FOR_THE_SOUL)
    elseif (csid == 3113) then
        player:completeMission(TOAU, tpz.mission.id.toau.IN_THE_BLOOD)
        player:setCharVar("TOAUM33_STARTDAY", VanadielDayOfTheYear())
        player:needToZone(true)
        player:addItem(2187)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 2187)
        player:addMission(TOAU, tpz.mission.id.toau.SENTINELS_HONOR)
    elseif (csid == 3130) then
        player:completeMission(TOAU, tpz.mission.id.toau.SENTINELS_HONOR)
        player:setCharVar("TOAUM33_STARTDAY", 0)
        player:addMission(TOAU, tpz.mission.id.toau.TESTING_THE_WATERS)
    elseif (csid == 3138) then
        player:completeMission(TOAU, tpz.mission.id.toau.FANGS_OF_THE_LION)
        player:addKeyItem(tpz.ki.MYTHRIL_MIRROR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MYTHRIL_MIRROR)
        player:setTitle(tpz.title.NASHMEIRAS_LOYALIST)
        player:addMission(TOAU, tpz.mission.id.toau.NASHMEIRAS_PLEA)
    elseif (csid == 3139) then
        player:completeMission(TOAU, tpz.mission.id.toau.RAGNAROK)
        player:addMission(TOAU, tpz.mission.id.toau.IMPERIAL_CORONATION)
    elseif (csid == 3144) then
        player:completeMission(TOAU, tpz.mission.id.toau.THE_EMPRESS_CROWNED)
        player:addItem(16070)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 16070)
        player:addMission(TOAU, tpz.mission.id.toau.ETERNAL_MERCENARY)
    elseif (csid == 3149) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MYTHRIL_MIRROR)
        player:addKeyItem(tpz.ki.MYTHRIL_MIRROR)
    elseif (csid == 3076 and option == 0) then
        player:setCharVar("AhtUrganStatus", 1)
    elseif csid == 5000 then
        player:setCharVar("PromotionPFC", 1)
    elseif csid == 5002 then
        player:confirmTrade()
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PFC_WILDCAT_BADGE)
        player:addKeyItem(tpz.ki.PFC_WILDCAT_BADGE)
        player:setCharVar("PromotionPFC", 0)
        player:setCharVar("AssaultPromotion", 0)
    elseif csid == 5020 then
        player:setCharVar("PromotionSP", 1)
    elseif csid == 5022 then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SP_WILDCAT_BADGE)
        player:addKeyItem(tpz.ki.SP_WILDCAT_BADGE)
        player:setCharVar("PromotionSP", 0)
        player:setCharVar("AssaultPromotion", 0)
    end
end
