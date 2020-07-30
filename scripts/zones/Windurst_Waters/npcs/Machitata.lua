-----------------------------------
-- Area: Windurst Waters
--  NPC: Machitata
-- Involved in Quest: Hat in Hand
-- !pos 163 0 -22 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end
    hatstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
    if ((hatstatus == 1  or player:getCharVar("QuestHatInHand_var2") == 1) and testflag(tonumber(player:getCharVar("QuestHatInHand_var")), 1) == false) then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, tpz.ki.NEW_MODEL_HAT)
        player:addCharVar("QuestHatInHand_var", 1)
        player:addCharVar("QuestHatInHand_count", 1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
