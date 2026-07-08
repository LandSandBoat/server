-----------------------------------
-- Area: Kazham
--  NPC: Thali Mhobrum
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
{ x = 55.816410, y = -11.000000, z = -43.992680 },
{ x = 54.761787, z = -44.046181 },
{ x = 51.805824, z = -44.200321 },
{ x = 52.922001, z = -44.186420 },
{ x = 51.890709, z = -44.224312 },
{ x = 47.689358, z = -44.374969 },
{ x = 52.826096, z = -44.191029 },
{ x = 47.709465, z = -44.374393 },
{ x = 52.782181, z = -44.192482 },
{ x = 47.469643, z = -44.383091 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('BathedInScent') == 1 then
        player:startEvent(163) -- scent from Blue Rafflesias
    end
end

return entity
