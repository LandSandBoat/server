-------------------------------------
-- Area: Southern San d'Oria
--  NPC: Glenne
-- Starts and Finishes Quest: A Sentry's Peril
-- !pos -122 -2 15 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-------------------------------------

require("scripts/globals/pathfind")

local path =
{
    -121.512833, -2.000000, 14.492509,
    -122.600044, -2.000000, 14.535807,
    -123.697128, -2.000000, 14.615446,
    -124.696846, -2.000000, 14.707844,
    -123.606018, -2.000000, 14.601295,
    -124.720863, -2.000000, 14.709210,
    -123.677681, -2.000000, 14.608237,
    -124.752579, -2.000000, 14.712106,
    -123.669525, -2.000000, 14.607473,
    -124.788277, -2.000000, 14.715488,
    -123.792847, -2.000000, 14.619405,
    -124.871826, -2.000000, 14.723736
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrol(npc, path)
end

function onTrade(player, npc, trade)
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SENTRY_S_PERIL) == QUEST_ACCEPTED and
        trade:hasItemQty(601, 1) and count == 1) then
            player:startEvent(513)
            npc:wait()
    end

end

function onTrigger(player, npc)

    local aSentrysPeril = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_SENTRY_S_PERIL)

    npc:wait()

    if (aSentrysPeril == QUEST_AVAILABLE) then
        player:startEvent(510)
    elseif (aSentrysPeril == QUEST_ACCEPTED) then
        if (player:hasItem(600) == true or player:hasItem(601) == true) then
            player:startEvent(520)
        else
            player:startEvent(644)
        end
    elseif (aSentrysPeril == QUEST_COMPLETED) then
        player:startEvent(521)
    else
        npc:wait(0)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)

    npc:wait(5000)

    if (csid == 510 and option == 0) then
        if (player:getFreeSlotsCount() > 0) then
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.A_SENTRY_S_PERIL)
            player:addItem(600)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 600)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 600) -- Dose of ointment
        end
    elseif (csid == 644) then
        if (player:getFreeSlotsCount() > 0) then
            player:addItem(600)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 600)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 600) -- Dose of ointment
        end
    elseif (csid == 513) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 12832) -- Bronze Subligar
        else
            player:tradeComplete()
            player:addTitle(tpz.title.RONFAURIAN_RESCUER)
            player:addItem(12832)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12832) -- Bronze Subligar
            player:addFame(SANDORIA, 30)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.A_SENTRY_S_PERIL)
        end
    end

end
