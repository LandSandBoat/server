-----------------------------------
-- Area: Port Bastok
--  NPC: Otto
-- Standard Info NPC
-- Involved in Quest: The Siren's Tear
-- !pos -145.929 -7.48 -13.701 236
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local SirensTear = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.THE_SIREN_S_TEAR)

    if (SirensTear == QUEST_ACCEPTED and player:getCharVar("SirensTear") == 0) then
        player:startEvent(5)
    else
        player:startEvent(20)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
