-----------------------------------
-- Area: Norg
--  NPC: Louartain
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------

local path =
{
    41.878349, -6.282223, 10.820915,
    42.088036, -6.282223, 11.867051,
    42.096603, -6.282223, 12.939011,
    42.104187, -6.282223, 17.270992,
    42.126625, -6.282223, 14.951096,
    42.097260, -6.282223, 10.187170,
    42.104218, -6.282223, 17.303179,
    42.128235, -6.282223, 14.767291,
    42.097534, -6.282223, 10.223410
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
    player:startEvent(84)
    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    npc:wait(0)
end
