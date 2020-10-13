-----------------------------------
-- Area: Port San d'Oria
--  NPC: Arminibit
-- Standard Info NPC
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getMainLvl() >= 30 and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST) == QUEST_AVAILABLE) then
        player:startEvent(24)
    else
        player:startEvent(587)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 24) then
        player:setCharVar("TheHolyCrest_Event", 1)
    end

end
