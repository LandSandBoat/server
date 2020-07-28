-----------------------------------
-- Area: Windurst Waters
--  NPC: Clais
-- Involved In Quest: Hat in Hand
-- !pos -31 -3 11 238
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end
    hatstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
    if ((hatstatus == 1 or player:getCharVar("QuestHatInHand_var2") == 1) and testflag(tonumber(player:getCharVar("QuestHatInHand_var")), 8) == false) then
        player:startEvent(57) -- Show Off Hat
    else
        player:startEvent(602) -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 57) then  -- Show Off Hat
        player:addCharVar("QuestHatInHand_var", 8)
        player:addCharVar("QuestHatInHand_count", 1)
    end
end
