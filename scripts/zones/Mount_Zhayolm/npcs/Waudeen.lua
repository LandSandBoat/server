-----------------------------------
-- Area: Mount_Zhayolm
--  NPC: Waudeen
-- Type: Assault
-- !pos 673.882 -23.995 367.604 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local toauMission = player:getCurrentMission(TOAU)
    local beginnings = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS)

    -- BEGINNINGS
    if beginnings == QUEST_ACCEPTED then
        if not player:hasKeyItem(xi.ki.BRAND_OF_THE_FLAMESERPENT) then
            player:startEvent(10) -- brands you
        else
            player:startEvent(11) -- the way is neither smooth nor easy
        end

    -- ASSAULT
    elseif toauMission >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        local IPpoint = player:getCurrency("imperial_standing")
        if player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and not player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) then
            player:startEvent(209, 50, IPpoint)
        else
            player:startEvent(6)
            -- player:delKeyItem(xi.ki.ASSAULT_ARMBAND)
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(3)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- BEGINNINGS
    if csid == 10 then
        player:addKeyItem(xi.ki.BRAND_OF_THE_FLAMESERPENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_THE_FLAMESERPENT)

    -- ASSAULT
    elseif csid == 209 and option == 1 then
        player:delCurrency("imperial_standing", 50)
        player:addKeyItem(xi.ki.ASSAULT_ARMBAND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ASSAULT_ARMBAND)
    end
end

return entity
