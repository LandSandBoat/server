-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Phairupegiont
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -46 0.1 76 231
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 8) == false) then
        player:startEvent(806)
    else
        player:startEvent(663)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 806) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 8, true)
    end

end
