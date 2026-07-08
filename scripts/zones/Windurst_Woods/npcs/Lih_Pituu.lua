-----------------------------------
-- Area: Windurst Woods
--  NPC: Lih Pituu
-- Type: Bonecraft Adv. Image Support
-- !pos -5.471 -6.25 -141.211 241
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -5.057, y = -5.250, z = -136.979, wait =  6000 },
    { x = -9.271, y = -5.250, z = -139.831, wait = 10000 },
    { x = -4.695, y = -5.250, z = -141.494, wait = 10000 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    xi.crafting.oldImageSupportOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.crafting.oldImageSupportOnEventFinish(player, csid, option, npc)
end

return entity
