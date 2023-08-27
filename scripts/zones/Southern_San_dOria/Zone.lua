-----------------------------------
-- Zone: Southern_San_dOria (230)
-----------------------------------
local ID = require('scripts/zones/Southern_San_dOria/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/events/sunbreeze_festival')
require('scripts/quests/flyers_for_regine')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/chocobo')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, -292, -10, 90 , -258, 10, 105)
    quests.ffr.initZone(zone) -- register trigger areas 2 through 6

    applyHalloweenNpcCostumes(zone:getID())
    xi.events.starlightCelebration.applyStarlightDecorations(zone:getID())
    xi.events.sunbreeze_festival.showDecorations(zone:getID())

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
        player:setPos(161, -2, 161, 94)
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
    quests.ffr.onTriggerAreaEnter(player, triggerArea) -- player approaching Flyers for Regine NPCs
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 503 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
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
        GetNationRank(xi.nation.SANDORIA) == 1 and
        (GetNationRank(xi.nation.SANDORIA) ~= GetNationRank(xi.nation.BASTOK) and
        GetNationRank(xi.nation.SANDORIA) ~= GetNationRank(xi.nation.WINDURST))
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
