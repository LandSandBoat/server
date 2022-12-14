-----------------------------------
-- Area: Bastok Markets
--  NPC: Goblin Merrymaker
-- Type: Starlight Festival Event NPCs
-- Multiple locations
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

local startNodes =
{
    [17739906] =
    {
        { x = -276.000, y = -12.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -12.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -12.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -12.000, z = -68.000, wait = 0 },
    },
    [17739907] =
    {
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
    [17739908] =
    {
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
    [17739909] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
    },
    [17739910] =
    {
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
    },
    [17739911] =
    {
        { x = -265.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
    [17739912] =
    {
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
    [17739913] =
    {
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
    [17739914] =
    {
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
    [17739915] =
    {
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
}

local pathNodes =
{
    [1] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -265.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    },
    [2] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -243.000, y = -12.000, z = -32.000, wait = 0 },
        { x = -231.000, y = -12.000, z = -30.000, wait = 0 },
        { x = -200.000, y = -10.000, z = -31.000, wait = 0 },
        { x = -200.000, y = -10.000, z = 32.000, wait = 0 },
        { x = -241.000, y = -8.000, z = 32.000, wait = 0 },
        { x = -249.000, y = -4.000, z = 34.000, wait = 0 },
        { x = -253.000, y = -4.000, z = 41.000, wait = 0 },
        { x = -252.000, y = -4.000, z = 51.000, wait = 0 },
        { x = -239.000, y = -4.000, z = 52.000, wait = 0 },
        { x = -233.000, y = -4.000, z = 65.000, wait = 0 },
        { x = -209.000, y = -4.000, z = 65.000, wait = 0 },
        { x = -198.000, y = -4.000, z = 61.000, wait = 0 },
        { x = -189.000, y = -4.000, z = 60.000, wait = 0 },
        { x = -190.000, y = -4.000, z = 87.000, wait = 0 },
    },
    [3] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -243.000, y = -12.000, z = -58.000, wait = 0 },
        { x = -242.000, y = -9.000, z = -74.000, wait = 0 },
        { x = -198.000, y = -7.000, z = -72.000, wait = 0 },
        { x = -172.000, y = -7.000, z = -77.000, wait = 0 },
        { x = -128.000, y = -5.000, z = -97.000, wait = 0 },
        { x = -69.000, y = -5.000, z = -97.000, wait = 0 },
        { x = -53.000, y = -6.000, z = -82.000, wait = 0 },
        { x = -57.000, y = -6.000, z = -61.000, wait = 0 },
    },
    [4] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -265.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -279.000, y = -11.000, z = -108.000, wait = 0 },
        { x = -264.000, y = -10.000, z = -116.000, wait = 0 },
        { x = -249.000, y = -10.000, z = -121.000, wait = 0 },
        { x = -235.000, y = -9.000, z = -120.000, wait = 0 },
        { x = -205.000, y = -8.000, z = -105.000, wait = 0 },
        { x = -201.000, y = -8.000, z = -119.000, wait = 0 },
        { x = -200.000, y = -5.000, z = -145.000, wait = 0 },
        { x = -202.000, y = 2.000, z = -171.000, wait = 0 },
    },
    [5] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -265.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -324.000, y = -16.000, z = -33.000, wait = 0 },
        { x = -307.000, y = -16.000, z = -46.000, wait = 0 },
        { x = -322.000, y = -16.000, z = -53.000, wait = 0 },
        { x = -319.000, y = -16.000, z = -66.000, wait = 0 },
        { x = -322.000, y = -16.000, z = -83.000, wait = 0 },
        { x = -297.000, y = -14.000, z = -87.000, wait = 0 },
    },
    [6] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -265.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -281.000, y = -12.000, z = -97.000, wait = 0 },
        { x = -280.000, y = -12.000, z = -106.000, wait = 0 },
        { x = -294.000, y = -11.000, z = -115.000, wait = 0 },
        { x = -343.000, y = -11.000, z = -163.000, wait = 0 },
        { x = -294.000, y = -11.000, z = -115.000, wait = 0 },
        { x = -280.000, y = -11.000, z = -106.000, wait = 0 },
        { x = -281.000, y = -12.000, z = -97.000, wait = 0 },
    },
    [7] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -265.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -280.000, y = -12.000, z = -106.000, wait = 0 },
        { x = -292.000, y = -11.000, z = -113.000, wait = 0 },
        { x = -328.000, y = -11.000, z = -147.000, wait = 0 },
        { x = -311.000, y = -16.000, z = -164.000, wait = 0 },
        { x = -328.000, y = -11.000, z = -147.000, wait = 0 },
        { x = -292.000, y = -11.000, z = -113.000, wait = 0 },
        { x = -280.000, y = -12.000, z = -106.000, wait = 0 },
    },
    [8] =
    {
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -265.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -47.000, wait = 0 },
        { x = -287.000, y = -13.000, z = -49.000, wait = 0 },
        { x = -294.000, y = -13.000, z = -57.000, wait = 0 },
        { x = -297.000, y = -13.000, z = -68.000, wait = 0 },
        { x = -295.000, y = -13.000, z = -78.000, wait = 0 },
        { x = -286.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -279.000, y = -12.000, z = -108.000, wait = 0 },
        { x = -264.000, y = -11.000, z = -116.000, wait = 0 },
        { x = -249.000, y = -11.000, z = -121.000, wait = 0 },
        { x = -235.000, y = -10.000, z = -120.000, wait = 0 },
        { x = -205.000, y = -8.000, z = -105.000, wait = 0 },
        { x = -201.000, y = -8.000, z = -119.000, wait = 0 },
        { x = -200.000, y = -8.000, z = -145.000, wait = 0 },
        { x = -185.000, y = -8.000, z = -138.000, wait = 0 },
        { x = -173.000, y = -6.000, z = -124.000, wait = 0 },
        { x = -141.000, y = -6.000, z = -137.000, wait = 0 },
        { x = -123.000, y = -6.000, z = -144.000, wait = 0 },
        { x = -110.000, y = -6.000, z = -144.000, wait = 0 },
        { x = -108.000, y = -6.000, z = -120.000, wait = 0 },
        { x = -127.000, y = -6.000, z = -117.000, wait = 0 },
        { x = -168.000, y = -6.000, z = -97.500, wait = 0 },
        { x = -175.000, y = -6.000, z = -94.000, wait = 0 },
        { x = -189.000, y = -6.000, z = -93.000, wait = 0 },
        { x = -224.000, y = -6.000, z = -115.000, wait = 0 },
        { x = -238.000, y = -8.000, z = -121.000, wait = 0 },
        { x = -262.000, y = -10.000, z = -117.000, wait = 0 },
        { x = -279.000, y = -10.000, z = -108.000, wait = 0 },
        { x = -279.000, y = -12.000, z = -97.000, wait = 0 },
        { x = -276.000, y = -13.000, z = -89.000, wait = 0 },
        { x = -266.000, y = -13.000, z = -86.000, wait = 0 },
        { x = -258.000, y = -13.000, z = -79.000, wait = 0 },
        { x = -255.000, y = -13.000, z = -68.000, wait = 0 },
    }
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
    xi.events.starlightCelebration.merryMakersGoblinOnTrigger(player, npc, ID)
end

entity.onPathComplete = function(npc)
    local estPath = npc:getLocalVar("[StarlightMerryMakers]EstPath")
    local pathCheck = npc:getLocalVar("[StarlightMerryMakers]Path")
    local rndMsg = math.random(1, 2)
    local rndPath = math.random(1, 8)

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
