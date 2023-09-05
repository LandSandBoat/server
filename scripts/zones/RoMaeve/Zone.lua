-----------------------------------
-- Zone: RoMaeve (122)
-----------------------------------
local ID = require('scripts/zones/RoMaeve/IDs')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
-----------------------------------
local zoneObject = {}

local function updateFullMoonStatus()
    local vanadielHour = VanadielHour()
    local zone = GetZone(xi.zone.ROMAEVE)
    local weather = zone:getWeather()
    local rovEnabled = xi.settings.main.ENABLE_ROV
    -- ROV: Make Ro'Maeve come to life between 6pm and 6am during a full moon, any weather
    -- Pre-ROV: between midnight and 3am during a full moon and clear weather
    if
        IsMoonFull()
    then
        if
            (rovEnabled == 1 and (vanadielHour >= 18 or vanadielHour < 6)) or
            (rovEnabled == 0 and (vanadielHour >= 0 and vanadielHour < 3) and
            (weather == xi.weather.NONE or weather == xi.weather.SUNSHINE))
        then
            local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
            local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)
            if
                moongate1:getLocalVar("romaeveActive") == 0
            then
                -- Loop over the affected NPCs: Moongates, bridges and fountain
                for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
                    GetNPCByID(i):setAnimation(xi.anim.OPEN_DOOR) -- Open them
                end

                moongate2:setUntargetable(true)
                moongate1:setUntargetable(true)
                moongate1:setLocalVar("romaeveActive", 1) -- Make this loop unavailable after firing
            end

            -- Clean up outside of full moon window
        else
            local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
            local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)
            if
                moongate1:getLocalVar("romaeveActive") == 1
            then
                for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
                    GetNPCByID(i):setAnimation(xi.anim.CLOSE_DOOR)
                end

                moongate2:setUntargetable(false)
                moongate1:setUntargetable(false)
                moongate1:setLocalVar("romaeveActive", 0) -- Make loop available again
            end
        end
    end
end

zoneObject.onInitialize = function(zone)
    local newPosition = npcUtil.pickNewPosition(ID.npc.BASTOK_7_1_QM, ID.npc.BASTOK_7_1_QM_POS, true)
    GetNPCByID(ID.npc.BASTOK_7_1_QM):setPos(newPosition.x, newPosition.y, newPosition.z)

    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.SHIKIGAMI_WEAPON)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneTick = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-0.008, -33.595, 123.478, 62)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameHour = function(zone)
    updateFullMoonStatus()
end

zoneObject.onZoneWeatherChange = function(weather)
    updateFullMoonStatus()
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
