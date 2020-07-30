-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chanpau
-- Optional Involvement in Quest: A Squire's Test II
-- !pos -152 -2 55 230
-------------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SQUIRE_S_TEST_II) == QUEST_ACCEPTED) then
        player:startEvent(629)
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM) == QUEST_COMPLETED) then
        local Fired = player:getCharVar("Fired")
        if Fired == 1 then
            player:startEvent(567) -- i got fired in a day
        else
            player:startEvent(505) -- theres work ill go check it out
        end
    else
        player:startEvent(566)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 505) then
        player:setCharVar("Fired", 1)
    end
end

-------for future use
--    player:startEvent(32691) -- starlight celebration
