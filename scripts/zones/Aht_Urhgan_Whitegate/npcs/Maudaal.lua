-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Maudaal
-----------------------------------

local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/npc_util")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local princeAndHopperStatus = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER)
    if princeAndHopperStatus == QUEST_AVAILABLE then
        player:startEvent(889)
    elseif princeAndHopperStatus == QUEST_ACCEPTED and player:getCharVar("princeandhopper") == 6 then
        player:startEvent(890)
    else
        player:startEvent(240)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 889 and option == 2 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER)
        player:setCharVar("princeandhopper", 1)
    elseif csid == 890 then
        npcUtil.completeQuest(
            player,
            AHT_URHGAN,
            tpz.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER,
            {item = 16270, var = "princeandhopper"}
        )
    end
end
