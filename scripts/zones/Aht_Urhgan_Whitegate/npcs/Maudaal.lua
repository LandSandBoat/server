-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Maudaal
-----------------------------------
local entity = {}

local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/npc_util")

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local princeAndHopperStatus = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER)
    if princeAndHopperStatus == QUEST_AVAILABLE then
        player:startEvent(889)
    elseif princeAndHopperStatus == QUEST_ACCEPTED and player:getCharVar("princeandhopper") == 6 then
        player:startEvent(890)
    else
        player:startEvent(240)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 889 and option == 2 then
        player:addQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER)
        player:setCharVar("princeandhopper", 1)
    elseif csid == 890 then
        npcUtil.completeQuest(
            player,
            AHT_URHGAN,
            xi.quest.id.ahtUrhgan.THE_PRINCE_AND_THE_HOPPER,
            {item = 16270, var = "princeandhopper"}
        )
    end
end

return entity
