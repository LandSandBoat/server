-----------------------------------
--
-- Zone: Ceizak Battlegrounds (261)
--
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/zone")
local ID = require("scripts/zones/Ceizak_Battlegrounds/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- Ergon Locus area at K-10
    zone:registerRegion(1, 357.819, 11, -250.201, 0, 0, 0)
    -- Ergon Locus area at I-8
    zone:registerRegion(2, 87.2, 8, 72.9, 0, 0, 0)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(431, 0, 178, 110)
    end

    return cs
end

-- Cutscene for Dances with Luopans.
local function triggerUncannySensationMessage(player)
    if player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS) == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.LUOPAN) and player:getCharVar("GEO_DWL_Luopan") == 0 then
            player:messageSpecial(ID.text.UNCANNY_SENSATION)
            player:setLocalVar("GEO_DWL_Locus_Area", 1)
        end
    end
end

zone_object.onRegionEnter = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function(x) triggerUncannySensationMessage(player) end,
        [2] = function(x) triggerUncannySensationMessage(player) end,
    }
end

zone_object.onRegionLeave = function(player, region)
    player:setLocalVar("GEO_DWL_Locus_Area", 0)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
