-----------------------------------
-- Helpers for otherAreas quests
-----------------------------------
local davoiID = zones[xi.zone.DAVOI]
-----------------------------------
xi = xi or {}
xi.otherAreas = xi.otherAreas or {}
xi.otherAreas.helpers = xi.otherAreas.helpers or {}
xi.otherAreas.helpers.TestMyMettle = {}

function xi.otherAreas.helpers.TestMyMettle.moveJar(npc)
    -- 5 min (offset by onGameHour frequency of ~2.5 min) to 3 hours
    -- full equation = ((2.5 * 10) * 6) to ((3 * 60) * 60)
    local randomHourSpan = math.random(125, 10800)

    SetServerVariable('Davoi_Jar_Move_Time', os.time() + randomHourSpan)

    local positions =
    {
        {  185.230, -0.865, -189.750 }, -- [0] J-9 Jar near campfire
        {   94.290, -8.450, -163.800 }, -- [1] I-8 Jar near lake
        {  275.770,  3.160, -204.120 }, -- [2] K-9 Jar near stump
        {  171.750, -3.300, -111.800 }, -- [3] J-8 Jar on platform
        {   58.300, -9.780, -132.430 }, -- [4] H-8 Jar near oak door
        {   25.080,  0.440, -107.300 }, -- [5] H-8 Jar near campfire
        { -106.770,  2.580,   26.060 }, -- [6] F-6 Jar north of Hut Flap
        { -128.720,  3.250, -237.600 }, -- [7] F-9 Jar near stump
        {  -36.720,  3.300, -218.270 }, -- [8] G-9 Jar near well
        {   54.800,  0.720, -202.950 }, -- [9] H-9 Jar near campfire
    }

    local newPosition = npcUtil.pickNewPosition(davoiID.npc.JAR, positions, false)

    npcUtil.queueMove(npc, newPosition)
end
