-----------------------------------
-- Warhorse Hoofprint global file
-----------------------------------
local bhaflauID = zones[xi.zone.BHAFLAU_THICKETS]
local caedarvaID = zones[xi.zone.CAEDARVA_MIRE]
local mountID = zones[xi.zone.MOUNT_ZHAYOLM]
local wajaomID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------

xi = xi or {}
xi.darkRider = {}
xi.darkRider.MAX_HOOFPRINTS_PER_DAY = 2

local hoofprintIds = {
    [xi.zone.WAJAOM_WOODLANDS] = {
        wajaomID.npc.HOOFPRINT,
        wajaomID.npc.HOOFPRINT + 1,
        wajaomID.npc.HOOFPRINT + 2,
    },
    [xi.zone.BHAFLAU_THICKETS] = {
        bhaflauID.npc.HOOFPRINT,
        bhaflauID.npc.HOOFPRINT + 1,
        bhaflauID.npc.HOOFPRINT + 2,
    },
    [xi.zone.MOUNT_ZHAYOLM] = {
        mountID.npc.HOOFPRINT,
        mountID.npc.HOOFPRINT + 1,
        mountID.npc.HOOFPRINT + 2,
    },
    [xi.zone.CAEDARVA_MIRE] = {
        caedarvaID.npc.HOOFPRINT,
        caedarvaID.npc.HOOFPRINT + 1,
        caedarvaID.npc.HOOFPRINT + 2,
    },
}

local hoofprintPositions = {
    [xi.zone.WAJAOM_WOODLANDS] = {
        { 400, -24, 2 }, -- K-9
        { 345, -18, -41 }, -- J-9 E edge
        { 221, -18, -63 }, -- J-9 W edge
        { 217, -17.5, -140 }, -- J-10
        { 185, -20.25, -200 }, -- I-10 E edge
        { 121, -16, -241 }, -- I-10 S edge
        { 0, -18, -265 }, -- H-10 S edge
        { -80, -18, -546 }, -- H-12
        { -175, -20.25, -562 }, -- G-12
        { -378, -9, -580 }, -- F-12 S edge
        { -625, -19, -345 }, -- D-11
        { -642, -16, -160 }, -- D-10
        { -532, -8.5, -64 }, -- E-9
        { -500, -18, 176 }, -- E-8
        { -400, -24, 281 }, -- F-7
        { -400, -24, 281 }, -- F-7
        { -237, -24, 403 }, -- G-6 NE
        { -258, -25.5, 497 }, -- G-6 N
        { -302, -26, 580 }, -- F-5 SE corner
        { -360, -32, 680 }, -- F-5 behind tower
        { 105, -26, 320 },  -- I-7
    },
    [xi.zone.BHAFLAU_THICKETS] = {
        { 447, -18, 266 }, -- I-8
        { 425, -20.25, 239 }, -- I-9
        { 298, -8.5, 211 }, -- H-8 center of open area
        { 338, -10, 255 }, -- H-8 E tunnel
        { 160, -16, 319 }, -- G-8
        { 20, -18.675, 240 }, -- F-8
        { 283, -23.75, 431 }, -- H-7 center
        { 240, -32, 480 }, -- H-7 NW
        { 185, -34, 514 }, -- G-7 top NE corner
        { 61, -34, 545 }, -- G-6 SW corner
        { 336, -18, 380 }, -- H-7 SE corner
        { 379, -17, 380 }, -- I-7 in tunnel
    },
    [xi.zone.MOUNT_ZHAYOLM] = {
        { -401, -14.5, 374 }, -- D/E-6
        { -458, -13, 357 }, -- D-6
        { -350, -14, 330 }, -- E-6 near manhole cover
        { -401, -14.5, 372 }, -- E-6 tip of protruding wall
        { 161, -14, -206 }, -- H-9 (near the Pugils to the south)
        { 278, -18, -294 }, -- I-10 (on the mound with the Eruca)
        { 598, -14, -4 }, -- K-8
        { 762, -14.5, -55 }, -- L-8
    },
    [xi.zone.CAEDARVA_MIRE] = {
        { -600, 4.5, -100 }, -- G-9 (2nd map)
        { 212, 0, -533 }, -- I-9
        { 280, -16, -357 }, -- J-8
        { 300, -15, -354 }, -- J-8 in north pool
        { 400, -7.5, -260 }, -- J-8 N at imp camp
        { 415, -10, -180 }, -- J-7
        { 160, -8, -320 }, -- I-8
    },
}

local hoofprintZones = {}
for zoneId, _ in pairs(hoofprintPositions) do
    hoofprintZones[#hoofprintZones + 1] = zoneId
end

-- Adds hoofprints if the current zone is the one picked for that day
xi.darkRider.addHoofprints = function(zone)
    -- We need a random number that's the same across servers,
    -- so we add a bunch of vanadiel time values, which will be the same across servers, but should
    -- result in a seemingly "random" area and positions each time when combined with the modulo operator.
    local fakeRandomNum = VanadielMoonPhase() + VanadielDayElement() + VanadielDayOfTheMonth() + VanadielDayOfTheYear()

    local areaIndex = math.fmod(fakeRandomNum, #hoofprintZones) + 1
    local pickedZoneId = hoofprintZones[areaIndex]

    if pickedZoneId ~= zone:getID() then
        return
    end

    local possiblePositions = utils.shuffle(hoofprintPositions[zone:getID()])
    local possibleHoofprintIds = hoofprintIds[zone:getID()]

    local daysSinceEpoch = VanadielUniqueDay()
    local currentHoofprintCount = zone:getLocalVar('HoofprintCount')

    local hoofprintsToAdd = math.fmod(fakeRandomNum, xi.darkRider.MAX_HOOFPRINTS_PER_DAY) + 1

    for i = 1, #possibleHoofprintIds do
        if hoofprintsToAdd <= 0 then
            break
        end

        local hoofprint = GetNPCByID(possibleHoofprintIds[i])
        if hoofprint ~= nil and hoofprint:getStatus() ~= xi.status.NORMAL then
            hoofprint:setPos(possiblePositions[i])
            hoofprint:setStatus(xi.status.NORMAL)
            hoofprint:setLocalVar('DaysSinceEpoch', daysSinceEpoch)
            currentHoofprintCount = currentHoofprintCount + 1
            hoofprintsToAdd = hoofprintsToAdd - 1
        else
            printf('Did not find hoofprint with ID: %d', possibleHoofprintIds[i])
        end
    end

    zone:setLocalVar('HoofprintCount', currentHoofprintCount)
end

-- Remove hoofprints at 06:00 from previous day
xi.darkRider.onGameHour = function(zone)
    if VanadielHour() ~= 6 then
        return
    end

    local hoofprintCount = zone:getLocalVar('HoofprintCount')
    if hoofprintCount == 0 then
        return
    end

    local daysSinceEpoch = VanadielUniqueDay()
    local possibleHoofprintIds = hoofprintIds[zone:getID()]
    for i = 1, #possibleHoofprintIds do
        local hoofprint = GetNPCByID(possibleHoofprintIds[i])

        -- Hide hoofprint if it was shown in a previous day
        if
            hoofprint ~= nil and
            hoofprint:getStatus() == xi.status.NORMAL and
            hoofprint:getLocalVar('DaysSinceEpoch') < daysSinceEpoch
        then
            hoofprint:setStatus(xi.status.DISAPPEAR)
            hoofprint:resetLocalVars()
            hoofprintCount = hoofprintCount - 1
        end
    end

    zone:setLocalVar('HoofprintCount', hoofprintCount)
end
