-----------------------------------
--
-- Zone: Yahse Hunting Grounds
--
-----------------------------------
local ID = require("scripts/zones/Yahse_Hunting_Grounds/IDs")
-----------------------------------

function onInitialize(zone)
    -- Ergon Locus area at F-6
    zone:registerRegion(1, -447.7, 6.6, 362.799, 0, 0, 0)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(361, 4, -211, 136)
    end
    return cs
end

-- Cutscene for Dances with Luopans.
local function triggerUncannySensationMessage(player)
    if player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.DANCES_WITH_LUOPANS) == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.LUOPAN) and player:getCharVar("GEO_DWL_Luopan") == 0 then
            player:messageSpecial(ID.text.UNCANNY_SENSATION)
            player:setLocalVar("GEO_DWL_Locus_Area", 1)
        end
    end
end

function onRegionEnter(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function(x) triggerUncannySensationMessage(player) end,
    }
end

function onRegionLeave(player, region)
    player:setLocalVar("GEO_DWL_Locus_Area", 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
