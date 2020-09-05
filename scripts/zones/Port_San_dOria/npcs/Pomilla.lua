-----------------------------------
-- Area: Port San d'Oria
--  NPC: Pomilla
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -38 -4 -55 232
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 11) == false) then
        player:startEvent(749)
    else
        player:startEvent(562)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 749) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 11, true)
    end

end
