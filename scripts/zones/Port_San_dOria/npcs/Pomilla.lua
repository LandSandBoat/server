-----------------------------------
-- Area: Port San d'Oria
--  NPC: Pomilla
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -38 -4 -55 232
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 11)) then
        player:startEvent(749)
    else
        player:startEvent(562)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 749) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 11, true))
    end

end
