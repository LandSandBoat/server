-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ulamaal
-- Type: Standard NPC
-- !pos 93.512 -7.5 -128.530 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local vanishProg = player:getCharVar("vanishingactCS")

    if player:getCharVar("deliveringTheGoodsCS") == 1 then
        player:startEvent(40)
    elseif
        player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.DELIVERING_THE_GOODS) == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.VANISHING_ACT) == QUEST_AVAILABLE and
        player:getCharVar("VANISHING_ACT_waitJPMidnight") < os.time()
    then
        player:startEvent(42)
    elseif vanishProg == 4 and player:hasKeyItem(xi.ki.RAINBOW_BERRY) then
        player:startEvent(45)
    elseif vanishProg >= 2 then
        player:startEvent(54)
    else
        player:startEvent(53)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 40 then
        player:setCharVar("deliveringTheGoodsCS", 2)
    elseif csid == 42 and option == 0 then
        player:addQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.VANISHING_ACT)
        player:setCharVar("vanishingactCS", 2)
        player:setCharVar("VANISHING_ACT_waitJPMidnight", 0)
    elseif csid == 45 and npcUtil.completeQuest(player, AHT_URHGAN, xi.quest.id.ahtUrhgan.VANISHING_ACT, {item=2185, var="vanishingactCS"}) then
        player:delKeyItem(xi.ki.RAINBOW_BERRY)
    end
end

return entity
