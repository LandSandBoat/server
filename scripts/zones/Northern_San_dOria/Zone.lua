-----------------------------------
-- Zone: Northern_San_dOria (231)
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.server.setExplorerMoogles(ID.npc.EXPLORER_MOOGLE)

    zone:registerCuboidTriggerArea(1, -7, -3, 110, 7, -1, 155)
    quests.ffr.initZone(zone) -- register trigger areas 2 through 6

    xi.events.harvestFestival.applyHalloweenNpcCostumes(zone:getID())
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { -1 }

    if
        player:getCharVar('peaceForTheSpiritCS') == 5 and
        player:getFreeSlotsCount() >= 1
    then
        cs = { 49 }
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(130, -0.2, -3, 160)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
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

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 569 then
        player:setPos(0, 0, -13, 192, 233)
    elseif
        csid == 49 and
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT, { item = 12513, fame = 60, title = xi.title.PARAGON_OF_RED_MAGE_EXCELLENCE })
    then
        player:setCharVar('peaceForTheSpiritCS', 0)
    elseif csid == 16 then
        player:setCharVar('Wait1DayM8-1_date', 0)
        player:setCharVar('Mission8-1Completed', 1)
    end
end

return zoneObject
