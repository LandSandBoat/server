-----------------------------------
-- Area: Bastok Markets
--  NPC: Biggorf
-- Standard Info NPC
-- Involved in Quest: The Bare Bones
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

BareBones = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.THE_BARE_BONES)

    if (BareBones == QUEST_ACCEPTED) then
        player:startEvent(257)
    else
        player:startEvent(126)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
