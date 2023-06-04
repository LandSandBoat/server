-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Belgidiveau
-- Starts and Finishes Quest: Trouble at the Sluice
-- !pos -98 0 69 231
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local troubleAtTheSluice = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
    local hasNeutralizerKI = player:hasKeyItem(xi.ki.NEUTRALIZER)

    if
        troubleAtTheSluice == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3
    then
        player:startEvent(57)
    elseif troubleAtTheSluice == QUEST_ACCEPTED and not hasNeutralizerKI then
        player:startEvent(55)
    elseif hasNeutralizerKI then
        player:startEvent(56)
    else
        player:startEvent(585)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 57 and option == 0 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
        player:setCharVar("troubleAtTheSluiceVar", 1)
    elseif csid == 56 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16706) -- Heavy Axe
        else
            player:tradeComplete()
            player:delKeyItem(xi.ki.NEUTRALIZER)
            player:addItem(16706)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16706) -- Heavy Axe
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)
        end
    end
end

return entity
