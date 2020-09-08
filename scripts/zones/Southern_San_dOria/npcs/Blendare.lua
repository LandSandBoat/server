-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Blendare
-- Type: Standard NPC
-- !pos 33.033 0.999 -30.119 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- FLYERS FOR REGINE
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        if player:getCharVar("tradeBlendare") == 0 then
            player:messageSpecial(ID.text.FLYER_ACCEPTED)
            player:messageSpecial(ID.text.FFR_BLENDARE)
            player:addCharVar("FFR", -1)
            player:setCharVar("tradeBlendare", 1)
            player:confirmTrade()
        else
            player:messageSpecial(ID.text.FLYER_ALREADY)
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(606)  -- my brother always takes my sweets
--    player:startEvent(598)   --did nothing no speech or text
--    player:startEvent(945)    --black screen and hang
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 606) then
        player:setCharVar("BrothersCS", 1)
    end
end
