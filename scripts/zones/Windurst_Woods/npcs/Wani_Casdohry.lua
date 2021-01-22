-----------------------------------
-- Area: Windurst Woods
--  NPC: Wani Casdohry
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local TwinstoneBonding = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.TWINSTONE_BONDING)

    if TwinstoneBonding == QUEST_COMPLETED then
        player:startEvent(492, 0, 13360)
    elseif TwinstoneBonding == QUEST_ACCEPTED then
        player:startEvent(489, 0, 13360)
    else
        player:startEvent(425)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
