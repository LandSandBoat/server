-----------------------------------
-- Area: Port San d'Oria
--  NPC: Perdiouvilet
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -59 -5 -29 232
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 10) == false) then
        player:startEvent(750)
    else
        player:startEvent(762)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 750) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 10, true)
    end

end
