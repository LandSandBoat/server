-----------------------------------
-- Area: Nashmau
--  NPC: Kyokyoroon
-- Standard Info NPC
-- !pos 18.020 -6.000 10.467 53
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.RAT_RACE) == QUEST_ACCEPTED and player:getCharVar("ratraceCS") == 5) then
        if (trade:hasItemQty(5595, 1) and trade:getItemCount() == 1) then
            player:startEvent(311)
        end
    end
end

entity.onTrigger = function(player, npc)
    local ratRaceProg = player:getCharVar("ratraceCS")

    if (ratRaceProg == 5) then
        player:startEvent(263)
    elseif (ratRaceProg == 6) then
        player:startEvent(316)
    elseif (player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.RAT_RACE) == QUEST_COMPLETED) then
        player:startEvent(317)
    else
        player:startEvent(263)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 311) then
        player:tradeComplete()
        player:setCharVar("ratraceCS", 6)
    end
end

return entity
