-----------------------------------
-- Zone: Yahse Hunting Grounds
-----------------------------------
local ID = zones[xi.zone.YAHSE_HUNTING_GROUNDS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.reives.setupZone(zone)

    -- Ergon Locus area at F-6
    zone:registerCylindricalTriggerArea(1, -447.7, 362.799, 6.6)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(361, 4, -211, 136)
    end

    return cs
end

-- Cutscene for Dances with Luopans.
local function triggerUncannySensationMessage(player)
    if player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS) == xi.questStatus.QUEST_ACCEPTED then
        if
            player:hasKeyItem(xi.ki.LUOPAN) and
            player:getCharVar('GEO_DWL_Luopan') == 0
        then
            player:messageSpecial(ID.text.UNCANNY_SENSATION)
            player:setLocalVar('GEO_DWL_Locus_Area', 1)
        end
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function(x)
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
