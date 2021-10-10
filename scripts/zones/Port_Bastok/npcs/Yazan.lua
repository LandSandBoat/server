-----------------------------------
-- Area: Port Bastok
--  NPC: Yazan
-- Starts Quests: Bite the Dust (100%)
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local BiteDust = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BITE_THE_DUST)

    if BiteDust ~= QUEST_AVAILABLE and trade:hasItemQty(1015, 1) and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:startEvent(193)
    end
end

entity.onTrigger = function(player, npc)
    local BiteDust = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BITE_THE_DUST)

    if BiteDust == QUEST_AVAILABLE then
        player:startEvent(191)
    elseif BiteDust == QUEST_ACCEPTED then
        player:startEvent(192)
    else
        player:startEvent(190)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 191 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BITE_THE_DUST)
    elseif csid == 193 then
        if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BITE_THE_DUST) == QUEST_ACCEPTED then
            player:addTitle(xi.title.SAND_BLASTER)
            player:addFame(BASTOK, 120)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BITE_THE_DUST)
        else
            player:addFame(BASTOK, 80)
        end

        player:addGil(xi.settings.GIL_RATE * 350)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 350)
    end
end

return entity
