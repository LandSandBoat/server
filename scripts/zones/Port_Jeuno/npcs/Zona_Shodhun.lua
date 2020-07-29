-----------------------------------
-- Area: Port Jeuno
--  NPC: Zona Shodhun
-- Starts and Finishes Quest: Pretty Little Things
-- !pos -175 -5 -4 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local count = trade:getItemCount()
    local gil = trade:getGil()
    local itemQuality = 0

    if (trade:getItemCount() == 1 and trade:getGil() == 0) then
        if (trade:hasItemQty(771, 1)) then        -- Yellow Rock
            itemQuality = 2
        elseif (trade:hasItemQty(769, 1)  or        -- Red Rock
                trade:hasItemQty(770, 1)  or        -- Blue Rock
                trade:hasItemQty(772, 1)  or        -- Green Rock
                trade:hasItemQty(773, 1)  or        -- Translucent Rock
                trade:hasItemQty(774, 1)  or        -- Purple Rock
                trade:hasItemQty(775, 1)  or        -- Black Rock
                trade:hasItemQty(776, 1)  or        -- White Rock
                trade:hasItemQty(957, 1)  or        -- Amaryllis
                trade:hasItemQty(2554, 1) or        -- Asphodel
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

    local PrettyLittleThings = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.PRETTY_LITTLE_THINGS)

    if (itemQuality == 2) then
        if (PrettyLittleThings == QUEST_COMPLETED) then
            player:startEvent(10023, 0, 246, 4)
        else
            player:startEvent(10023, 0, 246, 2)
        end
    elseif (itemQuality == 1) then
        if (PrettyLittleThings == QUEST_COMPLETED) then
            player:startEvent(10023, 0, 246, 5)
        elseif (PrettyLittleThings == QUEST_ACCEPTED) then
            player:startEvent(10023, 0, 246, 3)
        else
            player:startEvent(10023, 0, 246, 1)
        end
    else
        player:startEvent(10023, 0, 246, 0)
    end

end

function onTrigger(player, npc)
    player:startEvent(10023, 0, 246, 10)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 10023 and option == 4002) then
        player:moghouseFlag(8)
        player:messageSpecial(ID.text.MOGHOUSE_EXIT)
        player:addFame(JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.PRETTY_LITTLE_THINGS)
    elseif (csid == 10023 and option == 1) then
        player:tradeComplete()
        player:addQuest(JEUNO, tpz.quest.id.jeuno.PRETTY_LITTLE_THINGS)
    end
end
