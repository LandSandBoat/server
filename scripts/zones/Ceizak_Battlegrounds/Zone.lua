-----------------------------------
-- Zone: Ceizak Battlegrounds (261)
-----------------------------------
local ID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Ergon Locus area at K-10
    zone:registerTriggerArea(1, 357.819, 11, -250.201, 0, 0, 0)
    -- Ergon Locus area at I-8
    zone:registerTriggerArea(2, 87.2, 8, 72.9, 0, 0, 0)

    xi.reives.setupZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(431, 0, 178, 110)
    end

    return cs
end

-- Cutscene for Dances with Luopans.
local function triggerUncannySensationMessage(player)
    if
        player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS) == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.LUOPAN) and
        player:getCharVar('GEO_DWL_Luopan') == 0
    then
        player:messageSpecial(ID.text.UNCANNY_SENSATION)
        player:setLocalVar('GEO_DWL_Locus_Area', 1)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:GetTriggerAreaID()): caseof
    {
        [1] = function(x)
            triggerUncannySensationMessage(player)
        end,

        [2] = function(x)
            triggerUncannySensationMessage(player)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    player:setLocalVar('GEO_DWL_Locus_Area', 0)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
