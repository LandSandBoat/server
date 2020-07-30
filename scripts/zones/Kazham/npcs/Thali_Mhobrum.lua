-----------------------------------
-- Area: Kazham
--  NPC: Thali Mhobrum
-- Standard Info NPC
-----------------------------------

local path =
{
55.816410, -11.000000, -43.992680,
54.761787, -11.000000, -44.046181,
51.805824, -11.000000, -44.200321,
52.922001, -11.000000, -44.186420,
51.890709, -11.000000, -44.224312,
47.689358, -11.000000, -44.374969,
52.826096, -11.000000, -44.191029,
47.709465, -11.000000, -44.374393,
52.782181, -11.000000, -44.192482,
47.469643, -11.000000, -44.383091
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
end

function onTrigger(player, npc)
    if (player:getCharVar("BathedInScent") == 1) then
        player:startEvent(163) -- scent from Blue Rafflesias
        npc:wait()
    else
    player:startEvent(190)
    npc:wait()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    npc:wait(0)
end
