-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Maugie
-- Type: General Info NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 12) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    local grimySignpost = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS)
    if (grimySignpost == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 2) then
        player:startEvent(45)
    elseif (grimySignpost == QUEST_ACCEPTED) then
        if (player:getCharVar("CleanSignPost") == 15) then
            player:startEvent(44)
        else
            player:startEvent(43)
        end
    elseif (grimySignpost == QUEST_COMPLETED) then
        player:startEvent(42)
    else
        player:startEvent(46) -- default text
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 45 and option == 0) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS)
    elseif (csid == 44) then
        player:setCharVar("CleanSignPost", 0)
        player:addFame(SANDORIA, 30)
        player:addGil(GIL_RATE*1500)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1500)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS)
    end
end

return entity
