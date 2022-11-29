-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Goblin Merrymaker
-- Type: Starlight Festival Event NPCs
-- Multiple locations
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------

local entity = {}

local startNodes =
{
    [17723615] =
    {
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723616] =
    {
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723617] =
    {
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723618] =
    {
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723619] =
    {
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723620] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723621] =
    {
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723622] =
    {
        { x = -18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723623] =
    {
        { x = -18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [17723624] =
    {
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
}

local pathNodes =
{
    [1] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
    },
    [2] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 40.000, wait = 0 },
        { x = 50.000, y = 0.000, z = 40.000, wait = 0 },
        { x = 102.000, y = 0.000, z = 95.000, wait = 0 },
    },
    [3] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -21.000, y = 0.000, z = 53.000, wait = 0 },
        { x = -29.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -82.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -88.000, y = 0.000, z = 64.000, wait = 0 },
        { x = -98.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -112.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -152.000, y = 0.000, z = 102.000, wait = 0 },
        { x = -151.000, y = 0.000, z = 126.000, wait = 0 },
        { x = -175.000, y = 0.000, z = 140.000, wait = 0 },
        { x = -175.000, y = 0.000, z = 177.000, wait = 0 },
        { x = -168.000, y = 0.000, z = 188.000, wait = 0 },
        { x = -168.000, y = 0.000, z = 210.000, wait = 0 },
        { x = -128.000, y = 0.000, z = 209.000, wait = 0 },
        { x = -116.000, y = 0.000, z = 198.000, wait = 0 },
        { x = -128.000, y = 0.000, z = 185.000, wait = 0 },
        { x = -123.000, y = 0.000, z = 180.000, wait = 0 },
        { x = -124.000, y = 0.000, z = 140.000, wait = 0 },
        { x = -138.000, y = 0.000, z = 127.000, wait = 0 },
        { x = -151.000, y = 0.000, z = 126.000, wait = 0 },
    },
    [4] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -21.000, y = 0.000, z = 53.000, wait = 0 },
        { x = -29.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -82.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -88.000, y = 0.000, z = 64.000, wait = 0 },
        { x = -98.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -112.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -152.000, y = 0.000, z = 102.000, wait = 0 },
        { x = -151.000, y = 0.000, z = 126.000, wait = 0 },
        { x = -142.000, y = 0.000, z = 135.000, wait = 0 },
        { x = -132.000, y = 0.000, z = 146.000, wait = 0 },
        { x = -133.000, y = 0.000, z = 177.000, wait = 0 },
        { x = -144.000, y = 0.000, z = 189.000, wait = 0 },
        { x = -131.000, y = 0.000, z = 215.000, wait = 0 },
        { x = -130.000, y = 0.000, z = 253.000, wait = 0 },
    },
    [5] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -21.000, y = 0.000, z = 53.000, wait = 0 },
        { x = -29.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -82.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -88.000, y = 0.000, z = 64.000, wait = 0 },
        { x = -98.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -112.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -152.000, y = 0.000, z = 102.000, wait = 0 },
        { x = -151.000, y = 0.000, z = 126.000, wait = 0 },
        { x = -175.000, y = 0.000, z = 136.000, wait = 0 },
        { x = -176.000, y = 0.000, z = 146.000, wait = 0 },
        { x = -175.000, y = 0.000, z = 177.000, wait = 0 },
        { x = -168.000, y = 0.000, z = 186.000, wait = 0 },
        { x = -167.000, y = 0.000, z = 226.000, wait = 0 },
        { x = -172.000, y = 0.000, z = 232.000, wait = 0 },
        { x = -173.000, y = 0.000, z = 257.000, wait = 0 },
        { x = -151.000, y = 0.000, z = 278.000, wait = 0 },
        { x = -162.000, y = 0.000, z = 268.000, wait = 0 },
        { x = -167.000, y = 0.000, z = 273.000, wait = 0 },
        { x = -172.000, y = 0.000, z = 268.000, wait = 0 },
        { x = -167.000, y = 0.000, z = 273.000, wait = 0 },
        { x = -162.000, y = 0.000, z = 268.000, wait = 0 },
        { x = -151.000, y = 0.000, z = 278.000, wait = 0 },
    },
    [6] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -21.000, y = 0.000, z = 53.000, wait = 0 },
        { x = -29.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -82.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -88.000, y = 0.000, z = 64.000, wait = 0 },
        { x = -98.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -112.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -150.000, y = 0.000, z = 102.000, wait = 0 },
        { x = -178.000, y = 0.000, z = 102.000, wait = 0 },
        { x = -179.000, y = 0.000, z = 76.000, wait = 0 },
        { x = -239.000, y = 0.000, z = 74.000, wait = 0 },
        { x = -230.000, y = 0.000, z = 50.000, wait = 0 },
        { x = -238.000, y = 0.000, z = 16.000, wait = 0 },
    },
    [7] =
    {
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 0.046, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 20.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 34.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 46.000, wait = 0 },
        { x = 18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = 0.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -18.000, y = 0.000, z = 58.000, wait = 0 },
        { x = -21.000, y = 0.000, z = 53.000, wait = 0 },
        { x = -29.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -82.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -88.000, y = 0.000, z = 64.000, wait = 0 },
        { x = -98.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -112.000, y = 0.000, z = 60.000, wait = 0 },
        { x = -150.000, y = 0.000, z = 102.000, wait = 0 },
        { x = -178.000, y = 0.000, z = 102.000, wait = 0 },
        { x = -179.000, y = 0.000, z = 76.000, wait = 0 },
        { x = -239.000, y = 0.000, z = 74.000, wait = 0 },
        { x = -230.000, y = 0.000, z = 50.000, wait = 0 },
    },
}

local goblinText =
{
    [1] = ID.text.MERRYMAKER_TOY,
    [2] = ID.text.MERRYMAKER_TOY2,
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    local npcID = npc:getID()
    local currentPath = startNodes[npcID]
    npc:setPos(xi.path.first(startNodes[npcID]))
    npc:pathThrough(currentPath, xi.path.flag.COORDS)
end

entity.onTrade = function(player, npc, trade)
    xi.events.starlightCelebration.merryMakersGoblinOnTrade(player, npc, trade, ID)
end

entity.onPathPoint = function(npc)
end

entity.onTrigger = function(player, npc)
    xi.events.starlightCelebration.merryMakersGoblinOnTrigger(player, npc)
end

entity.onPathComplete = function(npc)
    local estPath = npc:getLocalVar("[StarlightMerryMakers]EstPath")
    local pathCheck = npc:getLocalVar("[StarlightMerryMakers]Path")
    local rndMsg = math.random(1, 2)
    local rndPath = math.random(1, 7)

    if estPath ~= 0 then -- has returned to establishing path
        npc:setLocalVar("[StarlightMerryMakers]EstPath", 0)
        npc:timer(1500, function(npcArg)
            npcArg:showText(npc, goblinText[rndMsg])
            npcArg:pathThrough(pathNodes[1], xi.path.flag.COORDS)
        end)
    else
        if pathCheck == 0 then -- on establishing path, can pick a new path
            npc:setLocalVar("[StarlightMerryMakers]Path", rndPath)
            npc:timer(1500, function(npcArg)
                npcArg:showText(npc, goblinText[rndMsg])
                npcArg:pathThrough(pathNodes[rndPath], xi.path.flag.COORDS)
            end)
        else -- on a path branch, return to estlabishing path
            npc:setLocalVar("[StarlightMerryMakers]Path", 0)
            npc:setLocalVar("[StarlightMerryMakers]EstPath", 1)
            npc:timer(1500, function(npcArg)
                npcArg:showText(npc, goblinText[rndMsg])
                npcArg:pathThrough(pathNodes[pathCheck], bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
            end)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.events.starlightCelebration.merryMakersGoblinOnFinish(player, csid, option, ID)
end

return entity
