------------------------------------
-- Starlight Celebration
------------------------------------
require("scripts/globals/settings")
------------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.starlightCelebration = xi.events.starlightCelebration or {}
xi.events.starlightCelebration.treeEntities = xi.events.starlightCelebration.treeEntities or {}

local event = SeasonalEvent:new("StarlightCelebration")

event:setEnableCheck(function()
    local month = tonumber(os.date("%m"))
    return month == 12
end)

local musicZones =
{
    xi.zone.UPPER_JEUNO,
    xi.zone.LOWER_JEUNO,
    xi.zone.PORT_JEUNO,
}

local starlightCelebrationMusic = 239
local grandDuchyOfJeunoMusic    = 110

xi.events.starlightCelebration.setMusic = function(musicId)
    for _, zoneId in pairs(musicZones) do
        local zone = GetZone(zoneId)
        if zone then
            -- Set the music of the zone, so that players zoning in will
            -- be sent it immediately
            zone:setBackgroundMusicDay(musicId)
            zone:setBackgroundMusicNight(musicId)

            -- Set the music for players already in the zone (this is wiped when
            -- they zone out)
            for _, player in pairs(zone:getPlayers()) do
                player:changeMusic(0, musicId)
                player:changeMusic(1, musicId)
            end
        end
    end
end

xi.events.starlightCelebration.treeData =
{
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        {  0, -277.910, -3.500,  78.470, "0x0000DD0400000000000000000000000000000000" },
        {  0, -268.574, -3.600,  82.015, "0x0000DD0400000000000000000000000000000000" },
        { 33, -259.108, -3.595,  77.425, "0x0000DD0400000000000000000000000000000000" },
        { 23, -279.120, -3.500, 115.110, "0x0000DD0400000000000000000000000000000000" },
        {  0, -268.681, -3.600, 117.314, "0x0000DD0400000000000000000000000000000000" },
        { 99, -199.327, -1.002,  45.192, "0x0000DD0400000000000000000000000000000000" },
        {  0, -166.937, -2.000,  55.714, "0x0000DD0400000000000000000000000000000000" },
        {  0, -150.206, -2.000,  53.012, "0x0000DD0400000000000000000000000000000000" },
        { 64,  -98.100, -2.074,  29.115, "0x0000DD0400000000000000000000000000000000" },
        { 99, -103.950,  2.000, -12.820, "0x0000DD0400000000000000000000000000000000" },
        {  0,  -80.605,  1.994,   7.681, "0x0000DD0400000000000000000000000000000000" },
        { 97,  -73.995,  2.000, -54.240, "0x0000DD0400000000000000000000000000000000" },
        {  0,  -26.506,  2.069, -99.088, "0x0000DD0400000000000000000000000000000000" },
        { 29,   21.210,  2.215, -93.820, "0x0000DD0400000000000000000000000000000000" },
        {  0,  -33.286,  1.988, -30.758, "0x0000DD0400000000000000000000000000000000" },
        {  0,  -24.230,  2.090,  -4.039, "0x0000DD0400000000000000000000000000000000" },
        { 61,  -12.050,  2.090,  -0.419, "0x0000DD0400000000000000000000000000000000" },
        {  0,  -15.542,  2.090,  13.174, "0x0000DD0400000000000000000000000000000000" },
        { 30,   15.009,  2.090,  13.172, "0x0000DD0400000000000000000000000000000000" },
        {  3,   13.030,  2.090,  -1.089, "0x0000DD0400000000000000000000000000000000" },
        { 25,   24.820,  2.090,  -4.169, "0x0000DD0400000000000000000000000000000000" },
        { 42,   34.944,  2.069, -30.738, "0x0000DD0400000000000000000000000000000000" },
        {  0,   77.994,  1.878,   5.711, "0x0000DD0400000000000000000000000000000000" },
        { 64,  103.950,  2.000, -14.320, "0x0000DD0400000000000000000000000000000000" },
        {  0,  103.665,  3.895,  18.656, "0x0000DD0400000000000000000000000000000000" },
        { 29,   94.510,  4.035,  70.780, "0x0000DD0400000000000000000000000000000000" },
        { 29,  127.710,  0.000,  70.280, "0x0000DD0400000000000000000000000000000000" },
        { 40,  152.600, -1.991, 157.099, "0x0000DD0400000000000000000000000000000000" },
        {  0,  173.410, -2.272, 201.179, "0x0000DD0400000000000000000000000000000000" },
        { 29,  127.710,  0.000,  70.280, "0x0000DD0400000000000000000000000000000000" },
        { 40,  152.600, -1.991, 157.099, "0x0000DD0400000000000000000000000000000000" },
    },
}

xi.events.starlightCelebration.generateTreeEntities = function()
    for zoneId, treeData in pairs(xi.events.starlightCelebration.treeData) do
        local zone = GetZone(zoneId)
        if zone then
            for _, treeEntry in pairs(treeData) do
                local rot  = treeEntry[1]
                local x    = treeEntry[2]
                local y    = treeEntry[3]
                local z    = treeEntry[4]
                local look = treeEntry[5]

                local npc = zone:insertDynamicEntity({
                    objtype = xi.objType.NPC,
                    name = "     ",
                    look = look,
                    x = x,
                    y = y,
                    z = z,
                    rotation = rot,
                    widescan = 0,
                    entityFlags = 2075,
                    namevis = 64,
                    releaseIdOnDisappear = true,
                })

                table.insert(xi.events.starlightCelebration.treeEntities, npc:getID())
            end
        end
    end
end

xi.events.starlightCelebration.showTrees = function(enabled)
    if enabled and #xi.events.starlightCelebration.treeEntities == 0 then
        xi.events.starlightCelebration.generateTreeEntities()
    end

    for _, entityID in pairs(xi.events.starlightCelebration.treeEntities) do
        local entity = GetNPCByID(entityID)
        if entity then
            if enabled then
                entity:setStatus(xi.status.NORMAL)
            else
                entity:setStatus(xi.status.INVISIBLE) -- TODO: Why doesn't DISAPPEAR work here?
            end
        end
    end

    if not enabled then
        xi.events.starlightCelebration.treeEntities = {}
    end
end

event:setStartFunction(function()
    xi.events.starlightCelebration.setMusic(starlightCelebrationMusic)
    xi.events.starlightCelebration.showTrees(true)
end)

event:setEndFunction(function()
    xi.events.starlightCelebration.setMusic(grandDuchyOfJeunoMusic)
    xi.events.starlightCelebration.showTrees(false)
end)

return event
