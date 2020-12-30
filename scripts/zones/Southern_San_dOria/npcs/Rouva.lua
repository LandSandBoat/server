-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rouva
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -17 2 10 230
-------------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 2)) then
        player:startEvent(808)
    else
        player:startEvent(664)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 808) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 2, true))
    end

end
