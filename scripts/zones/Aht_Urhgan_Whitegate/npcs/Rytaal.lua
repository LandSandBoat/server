-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rytaal
-- Type: Standard NPC
-- !pos 112.002 -1.338 -45.038 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/assault")
-----------------------------------
local entity = {}

local assaultOrders =
{
    [1] = {KI = xi.ki.LEUJAOAM_ASSAULT_ORDERS, points = "LEUJAOAM_ASSAULT_POINT"},
    [2] = {KI = xi.ki.MAMOOL_JA_ASSAULT_ORDERS, points = "MAMOOL_ASSAULT_POINT"},
    [3] = {KI = xi.ki.LEBROS_ASSAULT_ORDERS, points = "LEBROS_ASSAULT_POINT"},
    [4] = {KI = xi.ki.PERIQIA_ASSAULT_ORDERS, points = "PERIQIA_ASSAULT_POINT"},
    [5] = {KI = xi.ki.ILRUSI_ASSAULT_ORDERS, points = "ILRUSI_ASSAULT_POINT"},
    [6] = {KI = xi.ki.NYZUL_ISLE_ASSAULT_ORDERS, points = "NYZUL_ISLE_ASSAULT_POINT"},
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentAssault = player:getCurrentAssault()

    if
        player:getCurrentMission(TOAU) == xi.mission.id.toau.PRESIDENT_SALAHEEM and
        player:getVar("AhtUrganStatus") == 0
    then
        player:startEvent(269, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    elseif
        player:getCurrentMission(TOAU) <= xi.mission.id.toau.IMMORTAL_SENTRIES or
        player:getMainLvl() <= 49
    then
        player:startEvent(270)
    elseif currentAssault ~= 0 and player:getVar("assaultEntered") ~= 0 then
        if player:getVar("AssaultComplete") == 1 then
            player:messageText(player, ID.text.ASSAULT_COMPLETE)
            player:completeAssault(currentAssault)
        elseif currentAssault == 51 then
            player:messageText(player, ID.text.NYZUL_FAIL)
            player:delAssault(currentAssault)
        else
            local assaultPoint = assaultOrders[player:getVar("assaultEntered")].points
            player:addCurrency(assaultPoint, 100)
            player:messageText(player, ID.text.ASSAULT_FAILED)
            player:delAssault(currentAssault)
        end
        player:setVar("AssaultComplete", 0)
        player:setVar("assaultEntered", 0)
        player:setVar("Assault_Armband", 0)
        for _, v in pairs(assaultOrders) do
            if player:hasKeyItem(v.KI) then
                player:delKeyItem(v.KI)
            end
        end
    elseif
        player:getCurrentMission(TOAU) > xi.mission.id.toau.PRESIDENT_SALAHEEM or
        (player:getCurrentMission(TOAU) == xi.mission.id.toau.PRESIDENT_SALAHEEM and
        player:getVar("AhtUrganStatus") >= 1)
    then
        local currentTime = os.time()
        local refreshTime = player:getVar("lastTagTime")
        local idTagPeriod = 86400

        if player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
            idTagPeriod = 600
        end

        local diffPeriod =  math.floor((currentTime - refreshTime) / idTagPeriod)
        local tagStock = player:getCurrency("id_tags")
        local allTagsTimeCS = (refreshTime - 1009897200) + (diffPeriod * idTagPeriod)
        local haveimperialIDtag = 0
        local tagsAvail = 0

        while currentTime >= refreshTime and tagStock < 3 do
            refreshTime = refreshTime + idTagPeriod
            tagStock = tagStock + 1
        end
        
        player:setCurrency("id_tags", tagStock)
        player:setVar("lastTagTime", refreshTime)

        if player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) then
            haveimperialIDtag = 1
        end
        
        if tagStock > 0 then
            tagsAvail = 1
        end

        player:startEvent(268, 2, tagStock, currentAssault, haveimperialIDtag, allTagsTimeCS, tagsAvail)
    else
        -- Something went worng, clear all data
        player:setVar("AssaultComplete", 0)
        player:setVar("assaultEntered", 0)
        player:setVar("Assault_Armband", 0)
        player:delAssault(currentAssault)
        for _, v in pairs(assaultOrders) do
            if player:hasKeyItem(v.KI) then
                player:delKeyItem(v.KI)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local tagStock = player:getCurrency("id_tags")

    if csid == 269 then
        player:setVar("AhtUrganStatus",1)
    elseif csid == 268 and option == 1 and not player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and tagStock > 0 then
        if player:getCurrentAssault() ~= 0 then
            player:messageSpecial(ID.text.CANNOT_ISSUE_TAG, xi.ki.IMPERIAL_ARMY_ID_TAG)
            return
        end
        npcUtil.giveKeyItem(player, xi.ki.IMPERIAL_ARMY_ID_TAG)

        if tagStock >= 3 then
            player:setVar("lastTagTime", os.time() + 86400)
        end
        player:setCurrency("id_tags", tagStock - 1)
    elseif
        csid == 268 and
        option == 2 and
        assaultUtil.hasOrders(player) and
        not player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
    then
        local currentAssault = player:getCurrentAssault()
        
        for _, v in pairs(assaultOrders) do
            if player:hasKeyItem(v.KI) then
                player:delKeyItem(v.KI)
            end
        end
        npcUtil.giveKeyItem(player, xi.ki.IMPERIAL_ARMY_ID_TAG)
        player:delAssault(currentAssault)
    end
end

return entity
