-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Perfaumand
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -39 -3 69 233
-----------------------------------
require("scripts/globals/quests");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    local WildcatSandy = player:getCharVar("WildcatSandy");

    if (player:getQuestStatus(SANDORIA,tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy,18) == false) then
        player:startEvent(560);
    else
        player:startEvent(522);
    end

end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    if (csid == 560) then
        player:setMaskBit(player:getCharVar("WildcatSandy"),"WildcatSandy",18,true);
    end

end;
