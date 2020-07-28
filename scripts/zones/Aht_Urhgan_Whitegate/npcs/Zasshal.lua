-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Zasshal
-- Type: Salvage Key Item giver
-- !pos 101.468 -1 -20.088 50
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentday = tonumber(os.date("%j"))
    local lastPermit = player:getCharVar("LAST_PERMIT")
    local diffday = currentday - lastPermit
    local a1 = player:getAssaultPoint(LEUJAOAM_ASSAULT_POINT)
    local a2 = player:getAssaultPoint(MAMOOL_ASSAULT_POINT)
    local a3 = player:getAssaultPoint(LEBROS_ASSAULT_POINT)
    local a4 = player:getAssaultPoint(PERIQIA_ASSAULT_POINT)
    local a5 = player:getAssaultPoint(ILRUSI_ASSAULT_POINT)

    if player:hasKeyItem(tpz.ki.REMNANTS_PERMIT) then
        player:startEvent(821)
--[[    elseif player:getCurrentMission(TOAU) > tpz.mission.id.toau.GUESTS_OF_THE_EMPIRE and player:getMainLvl() >= 65 then
        if lastPermit == 0 then
            player:startEvent(818, a1, a2, a3, a4, a5)
        elseif diffday > 0 then
            player:startEvent(820, a1, a2, a3, a4, a5)
        end]]
    else
        player:startEvent(817)
    end
end

function onEventUpdate(player, csid, option)
    if (csid == 818 or csid == 820) and option == 10 and player:getAssaultPoint(LEUJAOAM_ASSAULT_POINT) >= 500 then
        player:setLocalVar("SalvageValid", 1)
    elseif (csid == 818 or csid == 820) and option == 11 and player:getAssaultPoint(MAMOOL_ASSAULT_POINT) >= 500 then
        player:setLocalVar("SalvageValid", 2)
    elseif (csid == 818 or csid == 820) and option == 12 and player:getAssaultPoint(LEBROS_ASSAULT_POINT) >= 500 then
        player:setLocalVar("SalvageValid", 3)
    elseif (csid == 818 or csid == 820) and option == 13 and player:getAssaultPoint(PERIQIA_ASSAULT_POINT) >= 500 then
        player:setLocalVar("SalvageValid", 4)
    elseif (csid == 818 or csid == 820) and option == 14 and player:getAssaultPoint(ILRUSI_ASSAULT_POINT) >= 500 then
        player:setLocalVar("SalvageValid", 5)
    end
end

function onEventFinish(player, csid, option)
    local currentday = tonumber(os.date("%j"))

    if (csid == 818 or csid == 820) and option == 100 then
        if player:getLocalVar("SalvageValid") == 1 then
            player:addKeyItem(tpz.ki.REMNANTS_PERMIT)
            player:delCurrency("LEUJAOAM_ASSAULT_POINT", 500)
        elseif player:getLocalVar("SalvageValid") == 2 then
            player:delCurrency("MAMOOL_ASSAULT_POINT", 500)
            player:addKeyItem(tpz.ki.REMNANTS_PERMIT)
        elseif player:getLocalVar("SalvageValid") == 3 then
            player:delCurrency("LEBROS_ASSAULT_POINT", 500)
            player:addKeyItem(tpz.ki.REMNANTS_PERMIT)
        elseif player:getLocalVar("SalvageValid") == 4 then
            player:delCurrency("PERIQIA_ASSAULT_POINT", 500)
            player:addKeyItem(tpz.ki.REMNANTS_PERMIT)
        elseif player:getLocalVar("SalvageValid") == 5 then
            player:delCurrency("ILRUSI_ASSAULT_POINT", 500)
            player:addKeyItem(tpz.ki.REMNANTS_PERMIT)
        end
        player:setLocalVar("SalvageValid", 0)
        player:setCharVar("LAST_PERMIT", currentday)
    end
end
