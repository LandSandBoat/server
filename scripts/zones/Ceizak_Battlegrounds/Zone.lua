-----------------------------------
-- Zone: Ceizak Battlegrounds (261)
-----------------------------------
local ID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Ergon Locus area at K-10
    zone:registerCylindricalTriggerArea(1, 357.819, -250.201, 11)

    -- Ergon Locus area at I-8
    zone:registerCylindricalTriggerArea(2, 87.2, 72.9, 8)

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
        player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS) == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.LUOPAN) and
        player:getCharVar('GEO_DWL_Luopan') == 0
    then
        player:messageSpecial(ID.text.UNCANNY_SENSATION)
        player:setLocalVar('GEO_DWL_Locus_Area', 1)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
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
