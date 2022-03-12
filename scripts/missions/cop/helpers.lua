-----------------------------------
-- Chains of Promathia Helpers
-----------------------------------
local hallID = require("scripts/zones/Hall_of_Transference/IDs")
-----------------------------------

xi = xi or {}
xi.cop = xi.cop or {}
xi.cop.helpers = xi.cop.helpers or {}

xi.cop.helpers.promyvionCrags =
{
    HOLLA = 1,
    DEM   = 2,
    MEA   = 3,
}

local shatteredTelepointInfo =
{
    [xi.zone.LA_THEINE_PLATEAU  ] = { xi.cop.helpers.promyvionCrags.HOLLA, 202, 212, { -266.76,   -0.635,  280.058,   0, 14 } },
    [xi.zone.KONSCHTAT_HIGHLANDS] = { xi.cop.helpers.promyvionCrags.DEM,   913, 918, { -267.194, -40.634, -280.019,   0, 14 } },
    [xi.zone.TAHRONGI_CANYON    ] = { xi.cop.helpers.promyvionCrags.MEA,   913, 918, {  280.066, -80.635,  -67.096, 191, 14 } },
}

xi.cop.helpers.shatteredTelepointOnTrigger = function(player, npc)
    if mission:getVar(player, 'Status') == 1 then -- TODO: Either move this, or set it in Mothercrystals
        local zoneId = player:getZoneID()
        local currentMemory = mission:getVar(player, 'Option')

        if
            currentMemory == 0 or
            currentMemory == shatteredTelepointInfo[zoneId][1]
        then
            local firstEntry = currentMemory == 0 and 1 or 0

            return mission:progressEvent(shatteredTelepointInfo[zoneId][2], 0, 0, firstEntry)
        else
            return mission:progressEvent(shatteredTelepointInfo[zoneId][3], currentMemory - 1)
        end
    end
end

xi.cop.helpers.shatteredTelepointEntry = function(player, csid, option, npc)
    if option == 0 then
        local zoneId = player:getZoneID()

        player:setPos(unpack(shatteredTelepointInfo[zoneId][4]))
    end
end

xi.cop.helpers.shatteredTelepointSealMemory = function(player, csid, option, npc)
    if option == 0 then
        local zoneId = player:getZoneID()

        mission:setVar(player, 'Option', 0)
        player:messageSpecial(zones[zoneId].text.MEMORIES_SEALED_OFF)
    end
end

xi.cop.helpers.cermetGateOnTrigger = function(player, npc)
    local cermetLocation = tonumber(string.sub(npc:getName(), -1)) + 1
    local currentMemory  = mission:getVar(player, 'Option')

    if currentMemory ~= cermetLocation then
        return mission:messageSpecial(hallID.text.DOOR_FIRMLY_SHUT):setPriority(1000)
    end
end

xi.cop.helpers.largeApparatusOnTrigger = function(player, npc)
    local currentMemory = mission:getVar(player, 'Option')

    if currentMemory == 0 then
        return mission:progressEvent(160)
    end
end
