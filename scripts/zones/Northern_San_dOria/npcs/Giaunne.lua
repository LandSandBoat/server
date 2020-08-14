-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Giaunne
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -13 0 36 231
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 5) == false) then
        player:startEvent(805)
    else
        player:startEvent(667)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 805) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 5, true)
    end

end
