-----------------------------------
-- Zone: Windurst_Woods (241)
-----------------------------------
local ID = require('scripts/zones/Windurst_Woods/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/events/sunbreeze_festival')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/chocobo')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    applyHalloweenNpcCostumes(zone:getID())
    xi.events.starlightCelebration.applyStarlightDecorations(zone:getID())
    xi.events.sunbreeze_festival.showDecorations(zone:getID())
    xi.events.sunbreeze_festival.showNPCs(zone:getID())
    xi.chocobo.initZone(zone)
    xi.conquest.toggleRegionalNPCs(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) + 37
        player:setPos(-138, -10, position, 0)
    end

    xi.moghouse.exitJobChange(player, prevZone)
end

zoneObject.afterZoneIn = function(player)
    xi.moghouse.afterZoneIn(player)
    xi.chocobo.confirmRentalAfterZoneIn(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
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

    if GetNationRank(xi.nation.WINDURST) == 1 then
        for _, name in pairs(regionalNPCNames) do
            local results = zone:queryEntitiesByName(name)
            for _, entity in pairs(results) do
                -- Will be the real entity if it has an X position
                if math.abs(entity:getXPos()) > 0 then
                    -- Hide all of these NPCs by default
                    entity:setStatus(xi.status.DISAPPEAR)
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
