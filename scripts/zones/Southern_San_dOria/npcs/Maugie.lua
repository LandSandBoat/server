-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Maugie
-- Type: General Info NPC
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")

function onTrade(player, npc, trade)
    -- FLYERS FOR REGINE
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        if player:getCharVar("tradeMaugie") == 0 then
            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:messageSpecial(ID.text.FFR_MAUGIE)
            player:addCharVar("FFR", -1)
            player:setCharVar("tradeMaugie", 1)
            player:confirmTrade()
        else
            player:messageSpecial(ID.text.FLYER_ALREADY)
        end
    end
end

function onTrigger(player, npc)
    local grimySignpost = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRIMY_SIGNPOSTS)
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 45 and option == 0) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.GRIMY_SIGNPOSTS)
    elseif (csid == 44) then
        player:setCharVar("CleanSignPost", 0)
        player:addFame(SANDORIA, 30)
        player:addGil(GIL_RATE*1500)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1500)
        player:completeQuest(SANDORIA, tpz.quest.id.sandoria.GRIMY_SIGNPOSTS)
    end
end
