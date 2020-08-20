-----------------------------------
-- Area: Windurst Walls
--  NPC: Ojha Rhawash
-- Starts and Finishes Quest: Flower Child
-- !pos -209 0 -134 239

-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")


function onTrade(player, npc, trade)

count = trade:getItemCount()
gil = trade:getGil()

itemQuality = 0
    if (trade:getItemCount() == 1 and trade:getGil() == 0) then
        if (trade:hasItemQty(956, 1)) then        -- Lilac
            itemQuality = 2
        elseif (trade:hasItemQty(957, 1)  or        -- Amaryllis
                trade:hasItemQty(2554, 1) or        -- Asphodel
                trade:hasItemQty(948, 1)  or        -- Carnation
                trade:hasItemQty(1120, 1) or        -- Casablanca
                trade:hasItemQty(1413, 1) or        -- Cattleya
                trade:hasItemQty(636, 1)  or        -- Chamomile
                trade:hasItemQty(959, 1)  or        -- Dahlia
                trade:hasItemQty(835, 1)  or        -- Flax Flower
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

    FlowerChild = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.FLOWER_CHILD)

    if (itemQuality == 2) then
        if (FlowerChild == QUEST_COMPLETED) then
            player:startEvent(10000, 0, 239, 4)
        else
            player:startEvent(10000, 0, 239, 2)
        end
    elseif (itemQuality == 1) then
        if (FlowerChild == QUEST_COMPLETED) then
            player:startEvent(10000, 0, 239, 5)
        elseif (FlowerChild == QUEST_ACCEPTED) then
            player:startEvent(10000, 0, 239, 3)
        else
            player:startEvent(10000, 0, 239, 1)
        end
    else
        player:startEvent(10000, 0, 239, 0)
    end

end

function onTrigger(player, npc)
    player:startEvent(10000, 0, 239, 10)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 10000 and option == 3002) then
        player:tradeComplete()
        player:completeQuest(WINDURST, tpz.quest.id.windurst.FLOWER_CHILD)
        player:addFame(WINDURST, 120)
        player:moghouseFlag(4)
        player:messageSpecial(ID.text.MOGHOUSE_EXIT)
    elseif (csid == 10000 and option == 1) then
        player:tradeComplete()
        player:addQuest(WINDURST, tpz.quest.id.windurst.FLOWER_CHILD)
    end
end
