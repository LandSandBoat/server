-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Leypoint
-- Teleport point, Quest -- NAVIGATING THE UNFRIENDLY SEAS RELATED --
-- !pos -200.027 -8.500 80.058 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.OLDUUM) == QUEST_COMPLETED and player:hasItem(15769) == false) then
        if (trade:hasItemQty(2217, 1) and trade:getItemCount() == 1) then -- Trade Lightning Band
            player:tradeComplete() -- Trade Complete
            player:addItem(15769) -- Receive Olduum Ring
            player:messageSpecial(ID.text.ITEM_OBTAINED, 15769) -- Message for Receiving Ring
        end
    end

    if (player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_ACCEPTED and player:getCharVar("NavigatingtheUnfriendlySeas") == 2) then
        if (trade:hasItemQty(2341, 1) and trade:getItemCount() == 1) then -- Trade Hydrogauge
            player:messageSpecial(ID.text.PLACE_HYDROGAUGE, 2341) -- You set the <item> in the trench.
            player:tradeComplete() --Trade Complete
            player:setCharVar("NavigatingtheUnfriendlySeas", 3)
            player:setCharVar("Leypoint_waitJTime", os.time() + 60) -- Wait 60 seconds.
        end
    end
end

function onTrigger(player, npc)

    if (player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_ACCEPTED and player:getCharVar("NavigatingtheUnfriendlySeas") == 3) then
        if (player:getCharVar("Leypoint_waitJTime") <= os.time()) then
            player:startEvent(508)
            player:setCharVar("NavigatingtheUnfriendlySeas", 4)   -- play cs for having waited enough time
        else
            player:messageSpecial(ID.text.ENIGMATIC_LIGHT, 2341)    -- play cs for not waiting long enough
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
