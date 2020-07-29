-----------------------------------
-- Area: Norg
--  NPC: Shivivi
-- Starts Quest: Secret of the Damp Scroll
-- !pos 68.729 -6.281 -6.432 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/quests")
require("scripts/globals/pathfind")

local path =
{
    59.698738, -6.282220, -0.842413,
    60.732185, -6.282220, -1.238357,
    61.612240, -6.282220, -1.784821,
    62.487907, -6.282220, -2.353283,
    72.850945, -6.282220, -9.126195,
    73.853767, -6.282220, -9.553433,
    74.856308, -6.282220, -9.683896,
    73.738983, -6.282220, -9.515277,
    72.831741, -6.282220, -9.069685,
    71.878197, -6.282220, -8.482308,
    70.934311, -6.282220, -7.872030,
    59.120659, -6.282220, -0.152556,
    58.260170, -6.282220, 0.364192,
    57.274529, -6.282220, 0.870113,
    56.267262, -6.282220, 1.278537,
    55.206066, -6.282220, 1.567320,
    54.107983, -6.282220, 1.825333,
    52.989727, -6.282220, 2.044612,
    51.915558, -6.282220, 2.155138,
    50.790054, -6.282220, 2.229803,
    48.477810, -6.282220, 2.361498,
    52.035912, -6.282220, 2.157254,
    53.062607, -6.282220, 2.020960,
    54.161610, -6.282220, 1.805452,
    55.267555, -6.282220, 1.563984,
    56.350552, -6.282220, 1.252867,
    57.370754, -6.282220, 0.821186,
    58.355640, -6.282220, 0.306034,
    59.294991, -6.282220, -0.273827,
    60.222008, -6.282220, -0.873351,
    72.913628, -6.282220, -9.164549,
    73.919716, -6.282220, -9.571738,
    75.007599, -6.282220, -9.696978,
    73.930611, -6.282220, -9.597872,
    72.944572, -6.282220, -9.142765,
    72.017265, -6.282220, -8.573789,
    71.103760, -6.282220, -7.982807,
    59.055004, -6.282220, -0.111382,
    58.112335, -6.282220, 0.439206
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    -- onPath(npc)
end

function onPath(npc)
    tpz.path.patrol(npc, path)
end
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    DampScroll = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
    mLvl = player:getMainLvl()

    if (DampScroll == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 3 and mLvl >= 10 and player:hasItem(1210) == true) then
        player:startEvent(31, 1210) -- Start the quest
    elseif (DampScroll == QUEST_ACCEPTED) then
        player:startEvent(32) -- Reminder Dialogue
    else
        player:startEvent(85)
    end

    npc:wait(0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 31) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.SECRET_OF_THE_DAMP_SCROLL)
    end

    npc:wait(0)
end
