-----------------------------------
-- Area: Port San d'Oria
--  NPC: Cherlodeau
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -20 -4 -69 232
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 12)) then
        player:startEvent(748)
    else
        player:startEvent(590)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 748) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 12, true))
    end

end
