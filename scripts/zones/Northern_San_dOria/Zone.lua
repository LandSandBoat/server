-----------------------------------
-- Zone: Northern_San_dOria (231)
-----------------------------------
local ID = require('scripts/zones/Northern_San_dOria/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/events/sunbreeze_festival')
require('scripts/quests/flyers_for_regine')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)

    zone:registerTriggerArea(1, -7, -3, 110, 7, -1, 155)
    quests.ffr.initZone(zone) -- register trigger areas 2 through 6

    applyHalloweenNpcCostumes(zone:getID())
    xi.events.starlightCelebration.applyStarlightDecorations(zone:getID())
    xi.events.sunbreeze_festival.showDecorations(zone:getID())
    xi.events.sunbreeze_festival.showNPCs(zone:getID())
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(130, -0.2, -3, 160)
    end

    if prevZone == player:getZoneID() then
        xi.moghouse.exitJobChange(player, prevZone)
    else
        player:setCharVar('[Moghouse]Exit_Pending', 0)
        player:setCharVar('[Moghouse]Exit_Job_Change', 0)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.moghouse.afterZoneIn(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function()  -- Chateau d'Oraguille access
            local pNation = player:getNation()
            local currentMission = player:getCurrentMission(pNation)

            if
                (pNation == 0 and player:getRank(player:getNation()) >= 2) or
                (pNation > 0 and player:hasCompletedMission(pNation, 5)) or
                (currentMission >= 5 and currentMission <= 9) or
                player:getRank(player:getNation()) >= 3
            then
                player:startEvent(569)
            else
                player:startEvent(568)
            end
        end,
    }

    quests.ffr.onTriggerAreaEnter(player, triggerArea) -- player approaching Flyers for Regine NPCs
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 569 then
        player:setCharVar('[Moghouse]Exit_Job_Change', 0)
        player:setPos(0, 0, -13, 192, 233)
    elseif csid == 16 then
        player:setCharVar("Wait1DayM8-1_date", 0)
        player:setCharVar("Mission8-1Completed", 1)
    end

    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

zoneObject.onGameHour = function(zone)
    xi.events.sunbreeze_festival.spawnFireworks(zone)
end

return zoneObject
