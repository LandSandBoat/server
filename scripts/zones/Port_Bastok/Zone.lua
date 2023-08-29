-----------------------------------
-- Zone: Port_Bastok (236)
-----------------------------------
local ID = require('scripts/zones/Port_Bastok/IDs')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/events/sunbreeze_festival')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, -112, -3, -17, -96, 3, -3)     -- event COP
    zone:registerTriggerArea(2, 53.5, 5, -165.3, 66.5, 6, -72) -- drawbridge area
    xi.conquest.toggleRegionalNPCs(zone)
    xi.events.starlightCelebration.applyStarlightDecorations(zone:getID())
    xi.events.sunbreeze_festival.showDecorations(zone:getID())
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP then
            cs = { 73 }
            player:setPos(-36.000, 7.000, -58.000, 194)
        else
            local position = math.random(1, 5) + 57
            player:setPos(position, 8.5, -239, 192)
        end
    end

    xi.moghouse.exitJobChange(player, prevZone)

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.moghouse.afterZoneIn(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, transport)
    if player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
        player:startEvent(71)
    else
        player:setPos(-97.42, -2.61, -7.93, 124)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 71 then
        player:setCharVar('[Moghouse]Exit_Job_Change', 0)
        player:setPos(0, 0, 0, 0, 224)
    end

    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

zoneObject.onGameHour = function(zone)
    local regionalNPCNames =
    {
        "Nokkhi_Jinjahl",
        "Ominous_Cloud",
        "Valeriano",
        "Mokop-Sankop",
        "Cheh_Raihah",
        "Nalta",
        "Dahjal"
    }

    if
        GetNationRank(xi.nation.BASTOK) == 1 and
        (GetNationRank(xi.nation.SANDORIA) ~= GetNationRank(xi.nation.BASTOK) and
        GetNationRank(xi.nation.BASTOK) ~= GetNationRank(xi.nation.WINDURST))
    then
        for _, name in pairs(regionalNPCNames) do
            local results = zone:queryEntitiesByName(name)
            for _, entity in pairs(results) do
                -- Will be the real entity if it has an X position
                if math.abs(entity:getXPos()) > 0 then
                    -- Hide all of these NPCs by default
                    entity:setStatus(xi.status.NORMAL)
                    -- If there is a clear winner, and not a tie,
                    -- show the NPCs
                end
            end
        end
    else
        for _, name in pairs(regionalNPCNames) do
            local results = zone:queryEntitiesByName(name)
            for _, entity in pairs(results) do
                -- Will be the real entity if it has an X position
                if math.abs(entity:getXPos()) > 0 then
                    -- Hide all of these NPCs by default
                    entity:setStatus(xi.status.DISAPPEAR)
                    -- If there is a clear winner, and not a tie,
                    -- show the NPCs
                end
            end
        end
    end

    xi.events.sunbreeze_festival.spawnFireworks(zone)
end

return zoneObject
