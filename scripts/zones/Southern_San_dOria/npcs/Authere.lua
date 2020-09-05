-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Authere
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos 33 1 -31 230
-------------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 1) == false) then
        player:startEvent(809)
    elseif (player:getCharVar("BrothersCS") == 1) then
        player:startEvent(597)  -- brothers cs
    else
        player:startEvent(605)  -- when i grow up im gonna fight like trion
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 809) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 1, true)
    elseif (csid == 597) then
        player:setCharVar("BrothersCS", 0)
    end
end

------- for later use
-- player:startEvent(598)  -- did nothing no cs or speech
