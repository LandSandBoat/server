-----------------------------------
-- Area: Kazham
--  NPC: Thali Mhobrum
-- Standard Info NPC
-----------------------------------
local entity = {}

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

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
end

entity.onPath = function(npc)
    tpz.path.patrol(npc, path)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("BathedInScent") == 1 then
        player:startEvent(163) -- scent from Blue Rafflesias
    else
        player:startEvent(190)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
