-----------------------------------
-- Mog House Exit Home Point Prompt Module
-----------------------------------
-- Restores the prompt to set your home point when exiting the Mog House after changing jobs.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/moghouse')
-----------------------------------
local m = Module:new('moghouse_exit_homepoint')

-- Variable used for this module to store the job snapshot in the player's character variables.
local jobSnapshot = 'moghouseExitJobSnapshot'

-- The current event ID for the Mog House exit prompt. May change with future updates. If this module ever breaks, check here first.
local exitEventId = 30004

-- Zones to prompt players to set their home point upon exiting the Mog House.
local exitZones =
{
    ['Southern_San_dOria'    ] = xi.zone.SOUTHERN_SAN_DORIA,
    ['Northern_San_dOria'    ] = xi.zone.NORTHERN_SAN_DORIA,
    ['Port_San_dOria'        ] = xi.zone.PORT_SAN_DORIA,
    ['Bastok_Mines'          ] = xi.zone.BASTOK_MINES,
    ['Bastok_Markets'        ] = xi.zone.BASTOK_MARKETS,
    ['Port_Bastok'           ] = xi.zone.PORT_BASTOK,
    ['Windurst_Waters'       ] = xi.zone.WINDURST_WATERS,
    ['Windurst_Walls'        ] = xi.zone.WINDURST_WALLS,
    ['Port_Windurst'         ] = xi.zone.PORT_WINDURST,
    ['Windurst_Woods'        ] = xi.zone.WINDURST_WOODS,
    ['RuLude_Gardens'        ] = xi.zone.RULUDE_GARDENS,
    ['Upper_Jeuno'           ] = xi.zone.UPPER_JEUNO,
    ['Lower_Jeuno'           ] = xi.zone.LOWER_JEUNO,
    ['Port_Jeuno'            ] = xi.zone.PORT_JEUNO,
    ['Al_Zahbi'              ] = xi.zone.AL_ZAHBI,
    ['Aht_Urhgan_Whitegate'  ] = xi.zone.AHT_URHGAN_WHITEGATE,
    ['Southern_San_dOria_[S]'] = xi.zone.SOUTHERN_SAN_DORIA_S,
    ['Bastok_Markets_[S]'    ] = xi.zone.BASTOK_MARKETS_S,
    ['Windurst_Waters_[S]'   ] = xi.zone.WINDURST_WATERS_S,
}

local promptZoneIds = {}
for _, zoneId in pairs(exitZones) do
    promptZoneIds[zoneId] = true
end

local currentJob = function(player)
    return player:getMainJob()
end

m:addOverride('xi.moghouse.onMoghouseZoneEvent', function(player, prevZone)
    -- Create a snapshot of the players current job when entering the mog house.
    if player:inMogHouse() then
        player:setCharVar(jobSnapshot, currentJob(player))

        return super(player, prevZone)
    end

    local moghouseExitPos    = player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0
    local baseCsId           = super(player, prevZone)
    local storedJob          = player:getCharVar(jobSnapshot)

    if moghouseExitPos and storedJob > 0 then
        player:setCharVar(jobSnapshot, 0)

        if
            baseCsId == -1 and
            promptZoneIds[player:getZoneID()] and
            storedJob ~= currentJob(player)
        then
            return exitEventId
        end
    end

    return baseCsId
end)

for zoneName in pairs(exitZones) do
    m:addOverride(string.format('xi.zones.%s.Zone.onEventFinish', zoneName), function(player, csid, option, npc)
        if csid == exitEventId then
            if option == 0 then
                player:setHomePoint()
                player:messageSpecial(zones[player:getZoneID()].text.HOMEPOINT_SET)
            end

            return
        end

        super(player, csid, option, npc)
    end)
end
