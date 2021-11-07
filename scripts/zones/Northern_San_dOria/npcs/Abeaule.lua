-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Abeaule
-- Starts and Finishes Quest: The Trader in the Forest, The Medicine Woman
-- !pos -136 -2 56 231
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local medicineWoman = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)

    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_TRADER_IN_THE_FOREST) == QUEST_COMPLETED and
        medicineWoman == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 3
    then
        if player:getCharVar("medicineWomanCS") == 1 then
            player:startEvent(615)
        else
            player:startEvent(613)
            player:setCharVar("medicineWomanCS", 1)
        end
    elseif medicineWoman == QUEST_ACCEPTED then
        if not player:hasKeyItem(xi.ki.COLD_MEDICINE) then
            player:showText(npc, ID.text.ABEAULE_DIALOG_HOME)
        else
            player:startEvent(614)
        end
    else
        player:showText(npc, ID.text.ABEAULE_DIALOG_THANKS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- "The Medicine Woman" Quest
    if (csid == 613 and option == 0) or (csid == 615 and option == 0) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    elseif csid == 614 then
        player:addTitle(xi.title.TRAVELING_MEDICINE_MAN)
        player:delKeyItem(xi.ki.COLD_MEDICINE)
        player:addGil(xi.settings.GIL_RATE * 2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 2100)
        player:addFame(SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    end
end

return entity
