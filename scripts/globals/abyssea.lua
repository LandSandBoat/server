-----------------------------------
-- Abyssea functions, vars, tables
-- DO NOT mess with the order
-- or change things to "elseif"!

-- TODO: Change these to use enums!
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/magic")
require("scripts/globals/zone")

tpz = tpz or {}
tpz.abyssea = tpz.abyssea or {}

-------------------------------------------------
-- local data
-------------------------------------------------

-- weaponskills for red weakness
local redWeakness =
{
    --light
    37, 161, 149, 180,
    --dark
    22, 133, 98,
    --fire
    34,
    --earth
    178,
    --wind
    20, 148,
    --ice
    51,
    --thunder
    144
}

local yellowWeakness =
{
    --fire
    [tpz.magic.element.FIRE] = { 146, 147, 176, 204, 591, 321, 455 },
    --ice
    [tpz.magic.element.ICE] = { 151, 152, 181, 206, 531, 324, 456 },
    --wind
    [tpz.magic.element.WIND] = { 156, 157, 186, 208, 534, 327, 457 },
    --earth
    [tpz.magic.element.EARTH] = { 161, 162, 191, 210, 555, 330, 458 },
    --ltng
    [tpz.magic.element.THUNDER] = { 166, 167, 196, 212, 644, 333, 459 },
    --water
    [tpz.magic.element.WATER] = { 171, 172, 201, 515, 336, 454 },
    --light
    [tpz.magic.element.LIGHT] = { 29, 30, 38, 39, 21, 112, 565, 461 },
    --dark
    [tpz.magic.element.DARK] = { 247, 245, 231, 260, 557, 348, 460 }
}

local blueWeakness =
{
    --6-14
    {196, 197, 198, 199, 212, 213, 214, 215, 18, 23, 24, 25, 118, 119, 120},
    --14-22
    {40, 41, 42, 135, 136, 71, 72, 103, 104, 87, 88, 151, 152, 55, 56},
    --22-6
    {165, 166, 167, 168, 169, 5, 6, 7, 8, 9, 176, 181, 182, 183, 184}
}

-- [ZoneID] = {Required Trades Event, Has Key Items Event, Missing Key Item Event}
local popEvents =
{
    [tpz.zone.ABYSSEA_KONSCHTAT]        = {1010, 1020, 1021},
    [tpz.zone.ABYSSEA_TAHRONGI]         = {1010, 1020, 1021},
    [tpz.zone.ABYSSEA_LA_THEINE]        = {1010, 1020, 1021},
    [tpz.zone.ABYSSEA_ATTOHWA]          = {1010, 1022, 1023},
    [tpz.zone.ABYSSEA_MISAREAUX]        = {1010, 1022, 1021},
    [tpz.zone.ABYSSEA_VUNKERL]          = {1010, 1015, 1120},
    [tpz.zone.ABYSSEA_ALTEPA]           = {1010, 1020, 1021},
    [tpz.zone.ABYSSEA_ULEGUERAND]       = {1010, 1020, 1025},
    [tpz.zone.ABYSSEA_GRAUBERG]         = {1010, 1020, 1021},
    [tpz.zone.ABYSSEA_EMPYREAL_PARADOX] = {1010, 1020, 1021},
}

-------------------------------------------------
-- public functions
-------------------------------------------------

-- returns Traverser Stone KI cap
tpz.abyssea.getMaxTravStones = function(player)
    local stones = 3

    for ki = tpz.ki.VIRIDIAN_ABYSSITE_OF_AVARICE, tpz.ki.VERMILLION_ABYSSITE_OF_AVARICE do
        if player:hasKeyItem(ki) then
            stones = stones + 1
        end
    end

    return stones
end

-- returns total Traverser Stone KI
-- (NOT the reserve value from currency menu)
tpz.abyssea.getTravStonesTotal = function(player)
    local stones = 0

    for ki = tpz.ki.TRAVERSER_STONE1, tpz.ki.TRAVERSER_STONE6 do
        if player:hasKeyItem(ki) then
            stones = stones + 1
        end
    end

    return stones
end

-- removes Traverser Stone KIs
tpz.abyssea.spendTravStones = function(player, spentstones)
    if spentstones == 4 then
        if player:hasKeyItem(tpz.ki.TRAVERSER_STONE6) then
            spentstones = 3
            player:delKeyItem(tpz.ki.TRAVERSER_STONE6)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE5) then
            spentstones = 3
            player:delKeyItem(tpz.ki.TRAVERSER_STONE5)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE4) then
            spentstones = 3
            player:delKeyItem(tpz.ki.TRAVERSER_STONE4)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE3) then
            spentstones = 3
            player:delKeyItem(tpz.ki.TRAVERSER_STONE3)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE2) then
            spentstones = 3
            player:delKeyItem(tpz.ki.TRAVERSER_STONE2)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE1) then
            spentstones = 3
            player:delKeyItem(tpz.ki.TRAVERSER_STONE1)
        end
    end

    if spentstones == 3 then
        if player:hasKeyItem(tpz.ki.TRAVERSER_STONE6) then
            spentstones = 2
            player:delKeyItem(tpz.ki.TRAVERSER_STONE6)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE5) then
            spentstones = 2
            player:delKeyItem(tpz.ki.TRAVERSER_STONE5)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE4) then
            spentstones = 2
            player:delKeyItem(tpz.ki.TRAVERSER_STONE4)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE3) then
            spentstones = 2
            player:delKeyItem(tpz.ki.TRAVERSER_STONE3)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE2) then
            spentstones = 2
            player:delKeyItem(tpz.ki.TRAVERSER_STONE2)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE1) then
            spentstones = 2
            player:delKeyItem(tpz.ki.TRAVERSER_STONE1)
        end
    end

    if spentstones == 2 then
        if player:hasKeyItem(tpz.ki.TRAVERSER_STONE6) then
            spentstones = 1
            player:delKeyItem(tpz.ki.TRAVERSER_STONE6)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE5) then
            spentstones = 1
            player:delKeyItem(tpz.ki.TRAVERSER_STONE5)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE4) then
            spentstones = 1
            player:delKeyItem(tpz.ki.TRAVERSER_STONE4)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE3) then
            spentstones = 1
            player:delKeyItem(tpz.ki.TRAVERSER_STONE3)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE2) then
            spentstones = 1
            player:delKeyItem(tpz.ki.TRAVERSER_STONE2)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE1) then
            spentstones = 1
            player:delKeyItem(tpz.ki.TRAVERSER_STONE1)
        end
    end

    if spentstones == 1 then
        if player:hasKeyItem(tpz.ki.TRAVERSER_STONE6) then
            player:delKeyItem(tpz.ki.TRAVERSER_STONE6)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE5) then
            player:delKeyItem(tpz.ki.TRAVERSER_STONE5)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE4) then
            player:delKeyItem(tpz.ki.TRAVERSER_STONE4)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE3) then
            player:delKeyItem(tpz.ki.TRAVERSER_STONE3)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE2) then
            player:delKeyItem(tpz.ki.TRAVERSER_STONE2)
        elseif player:hasKeyItem(tpz.ki.TRAVERSER_STONE1) then
            player:delKeyItem(tpz.ki.TRAVERSER_STONE1)
        end
    end
end

-- returns total "Abyssite of <thing>"
tpz.abyssea.getAbyssiteTotal = function(player, abyssite)
    local sojourn = 0
    local furtherance = 0
    local merit = 0

    if abyssite == "SOJOURN" then
        for ki = tpz.ki.IVORY_ABYSSITE_OF_SOJOURN, tpz.ki.EMERALD_ABYSSITE_OF_SOJOURN do
            if player:hasKeyItem(ki) then
                sojourn = sojourn + 1
            end
        end
        return sojourn
    elseif abyssite == "FURTHERANCE" then
        for ki = tpz.ki.SCARLET_ABYSSITE_OF_FURTHERANCE, tpz.ki.IVORY_ABYSSITE_OF_FURTHERANCE do
            if player:hasKeyItem(ki) then
                furtherance = furtherance + 1
            end
        end
        return furtherance
    elseif abyssite == "MERIT" then
        for ki = tpz.ki.AZURE_ABYSSITE_OF_MERIT, tpz.ki.INDIGO_ABYSSITE_OF_MERIT do
            if player:hasKeyItem(ki) then
                merit = merit + 1
            end
        end
        return merit
    end
end

-- returns total value of Demulune KeyItems
tpz.abyssea.getDemiluneAbyssite = function(player)
    local demilune = 0
    -- Todo: change this into proper bitmask
    if player:hasKeyItem(tpz.ki.CLEAR_DEMILUNE_ABYSSITE) then
        demilune = demilune + 1
    end
    if player:hasKeyItem(tpz.ki.COLORFUL_DEMILUNE_ABYSSITE) then
        demilune = demilune + 2
    end
    if player:hasKeyItem(tpz.ki.SCARLET_DEMILUNE_ABYSSITE) then
        demilune = demilune + 4
    end
    if player:hasKeyItem(tpz.ki.AZURE_DEMILUNE_ABYSSITE) then
        demilune = demilune + 8
    end
    if player:hasKeyItem(tpz.ki.VIRIDIAN_DEMILUNE_ABYSSITE) then
        demilune = demilune + 16
    end
    if player:hasKeyItem(tpz.ki.JADE_DEMILUNE_ABYSSITE) then
        demilune = demilune + 32
    end
    if player:hasKeyItem(tpz.ki.SAPPHIRE_DEMILUNE_ABYSSITE) then
        demilune = demilune + 64
    end
    if player:hasKeyItem(tpz.ki.CRIMSON_DEMILUNE_ABYSSITE) then
        demilune = demilune + 128
    end
    if player:hasKeyItem(tpz.ki.EMERALD_DEMILUNE_ABYSSITE) then
        demilune = demilune + 256
    end
    if player:hasKeyItem(tpz.ki.VERMILLION_DEMILUNE_ABYSSITE) then
        demilune = demilune + 512
    end
    if player:hasKeyItem(tpz.ki.INDIGO_DEMILUNE_ABYSSITE) then
        demilune = demilune + 1024
    end
    return demilune
end

tpz.abyssea.getNewYellowWeakness = function(mob)
    local day = VanadielDayOfTheWeek()
    local weakness = math.random(day - 1, day + 1)

    if weakness < 0 then weakness = 7 elseif weakness > 7 then weakness = 0 end
    local element = tpz.magic.dayElement[weakness]
    return yellowWeakness[element][math.random(#yellowWeakness[element])]
end

tpz.abyssea.getNewRedWeakness = function(mob)
    return redWeakness[math.random(#redWeakness)]
end

tpz.abyssea.getNewBlueWeakness = function(mob)
    local time = VanadielHour()
    local table = 3

    if time >= 6 and time < 14 then
        table = 1
    elseif time >= 14 and time < 22 then
        table = 2
    end

    return blueWeakness[table][math.random(#blueWeakness[table])]
end

-- trade to QM to pop mob
tpz.abyssea.qmOnTrade = function(player, npc, trade)
    -- validate QM pop data
    local zoneId = player:getZoneID()
    local pop = zones[zoneId].npc.QM_POPS[npc:getID()] -- TODO: Once I (Wren) finish entity-QC on all Abyssea zones, I must adjust the format of QM_POPS table
    if not pop then
        return false
    end

    -- validate trade-to-pop
    local reqTrade = pop[2]
    if #reqTrade == 0 or trade:getItemCount() ~= #reqTrade then
        return false
    end

    -- validate traded items
    for k, v in pairs(reqTrade) do
        if not trade:hasItemQty(v, 1) then
            return false
        end
    end

    -- validate nm status
    local nm = pop[4]
    if GetMobByID(nm):isSpawned() then
        return false
    end

    -- complete trade and pop nm
    player:tradeComplete()
    local dx = player:getXPos() + math.random(-1, 1)
    local dy = player:getYPos()
    local dz = player:getZPos() + math.random(-1, 1)
    GetMobByID(nm):setSpawn(dx, dy, dz)
    SpawnMob(nm):updateClaim(player)
    return true
end

tpz.abyssea.qmOnTrigger = function(player, npc)
    -- validate QM pop data
    local zoneId = player:getZoneID()
    local events = popEvents[zoneId]
    local pop = zones[zoneId].npc.QM_POPS[npc:getID()] -- TODO: Once I (Wren) finish entity-QC on all Abyssea zones, I must adjust the format of QM_POPS table
    if not pop then
        return false
    end

    -- validate nm status
    local nm = pop[4]
    if GetMobByID(nm):isSpawned() then
        return false
    end

    -- validate trade-to-pop
    local t = pop[2]
    if #t > 0 then
        for i = 1, 8, 1 do
            if not t[i] then
                t[i] = 0
            end
        end
        player:startEvent(events[1], t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8]) -- report required trades
        return true
    end

    -- validate ki-to-pop
    local kis = pop[3]
    if #kis == 0 then
        return false
    end

    -- validate kis
    local validKis = true
    for k, v in pairs(kis) do
        if not player:hasKeyItem(v) then
            validKis = false
            break
        end
    end

    -- infill kis
    for i = 1, 8, 1 do
        if not kis[i] then
            kis[i] = 0
        end
    end

    -- start event
    if validKis then
        player:setLocalVar("abysseaQM", npc:getID())
        player:startEvent(events[2], kis[1], kis[2], kis[3], kis[4], kis[5], kis[6], kis[7], kis[8]) -- player has all key items
        return true
    else
        player:startEvent(events[3], kis[1], kis[2], kis[3], kis[4], kis[5], kis[6], kis[7], kis[8]) -- player is missing key items
        return false
    end
end

tpz.abyssea.qmOnEventUpdate = function(player, csid, option)
    return false
end

tpz.abyssea.qmOnEventFinish = function(player, csid, option)
    local zoneId = player:getZoneID()
    local events = popEvents[zoneId]
    local pop = zones[zoneId].npc.QM_POPS[player:getLocalVar("abysseaQM")] -- TODO: Once I (Wren) finish entity-QC on all Abyssea zones, I must adjust the format of QM_POPS table
    player:setLocalVar("abysseaQM", 0)
    if not pop then
        return false
    end

    if csid == events[2] and option == 1 then
        -- delete kis
        local kis = pop[3]
        for k, v in pairs(kis) do
            if player:hasKeyItem(v) then
                player:delKeyItem(v)
            end
        end

        -- pop nm
        local nm = pop[4]
        local dx = player:getXPos() + math.random(-1, 1)
        local dy = player:getYPos()
        local dz = player:getZPos() + math.random(-1, 1)
        GetMobByID(nm):setSpawn(dx, dy, dz)
        SpawnMob(nm):updateClaim(player)
        return true
    end
end
