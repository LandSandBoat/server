-----------------------------------
-- Area: Port Bastok
--  NPC: Valah Molkot
-- Starts and Finishes Quest: A Lady's Heart
-- !pos 59 8 -221 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")


function onTrade(player, npc, trade)

count = trade:getItemCount()
gil = trade:getGil()

itemQuality = 0
    if (trade:getItemCount() == 1 and trade:getGil() == 0) then
        if (trade:hasItemQty(957, 1)) then        -- Amaryllis
            itemQuality = 2
        elseif (trade:hasItemQty(2554, 1) or        -- Asphodel
                trade:hasItemQty(948, 1)  or        -- Carnation
                trade:hasItemQty(1120, 1) or        -- Casablanca
                trade:hasItemQty(1413, 1) or        -- Cattleya
                trade:hasItemQty(636, 1)  or        -- Chamomile
                trade:hasItemQty(959, 1)  or        -- Dahlia
                trade:hasItemQty(835, 1)  or        -- Flax Flower
                trade:hasItemQty(956, 1)  or        -- Lilac
                trade:hasItemQty(2507, 1) or        -- Lycopodium Flower
                trade:hasItemQty(958, 1)  or        -- Marguerite
                trade:hasItemQty(1412, 1) or        -- Olive Flower
                trade:hasItemQty(938, 1)  or        -- Papaka Grass
                trade:hasItemQty(1411, 1) or        -- Phalaenopsis
                trade:hasItemQty(949, 1)  or        -- Rain Lily
                trade:hasItemQty(941, 1)  or        -- Red Rose
                trade:hasItemQty(1725, 1) or        -- Snow Lily
                trade:hasItemQty(1410, 1) or        -- Sweet William
                trade:hasItemQty(950, 1)  or        -- Tahrongi Cactus
                trade:hasItemQty(2960, 1) or        -- Water Lily
                trade:hasItemQty(951, 1)) then    -- Wijnruit
            itemQuality = 1
        end
    end

    ALadysHeart = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART)

    if (itemQuality == 2) then
        if (ALadysHeart == QUEST_COMPLETED) then
            player:startEvent(160, 0, 236, 4)
        else
            player:startEvent(160, 0, 236, 2)
        end
    elseif (itemQuality == 1) then
        if (ALadysHeart == QUEST_COMPLETED) then
            player:startEvent(160, 0, 236, 5)
        elseif (ALadysHeart == QUEST_ACCEPTED) then
            player:startEvent(160, 0, 236, 3)
        else
            player:startEvent(160, 0, 236, 1)
        end
    else
        player:startEvent(160, 0, 236, 0)
    end

end

function onTrigger(player, npc)
    player:startEvent(160, 0, 236, 10)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 160 and option == 2002) then
        player:tradeComplete()
        player:completeQuest(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART)
        player:addFame(BASTOK, 120)
        player:moghouseFlag(2)
        player:messageSpecial(ID.text.MOGHOUSE_EXIT)
    elseif (csid == 160 and option == 1) then
        player:tradeComplete()
        player:addQuest(BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART)
    end
end
