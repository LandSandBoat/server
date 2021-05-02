-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Leypoint
-- Teleport point, Quest -- NAVIGATING THE UNFRIENDLY SEAS RELATED
-- !pos -200.027 -8.500 80.058 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_ACCEPTED and player:getCharVar("NavigatingtheUnfriendlySeas") == 2 then
        if trade:hasItemQty(2341, 1) and trade:getItemCount() == 1 then -- Trade Hydrogauge
            player:messageSpecial(ID.text.PLACE_HYDROGAUGE, 2341) -- You set the <item> in the trench.
            player:tradeComplete() --Trade Complete
            player:setCharVar("NavigatingtheUnfriendlySeas", 3)
            player:setCharVar("Leypoint_waitJTime", os.time() + 60) -- Wait 60 seconds.
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_ACCEPTED and player:getCharVar("NavigatingtheUnfriendlySeas") == 3 then
        if player:getCharVar("Leypoint_waitJTime") <= os.time() then
            player:startEvent(508)
            player:setCharVar("NavigatingtheUnfriendlySeas", 4)   -- play cs for having waited enough time
        else
            player:messageSpecial(ID.text.ENIGMATIC_LIGHT, 2341)    -- play cs for not waiting long enough
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
