-----------------------------------
-- Area: Mhaura
--  NPC: Blandine
-- Start Quest: The Sand Charmz
-- !pos 23 -7 41 249
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()
    local theSandCharm = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM)

    if zPos <= 29 or zPos >= 38 or xPos <= 16 or xPos >= 32 then
        if
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
            theSandCharm == QUEST_AVAILABLE
        then
            player:startEvent(125) -- Start quest "The Sand Charm"
        elseif player:getCharVar("theSandCharmVar") == 2 then
            player:startEvent(124) -- During quest "The Sand Charm" - 2nd dialog
        elseif
            theSandCharm == QUEST_COMPLETED and
            player:getCharVar("SmallDialogByBlandine") == 1
        then
            player:startEvent(128) -- Thanks dialog of Bladine after "The Sand Charm"
        elseif theSandCharm == QUEST_COMPLETED then
            player:startEvent(129) -- New standard dialog after "The Sand Charm"
        else
            player:startEvent(122) -- Standard dialog
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 125 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM)
        player:setCharVar("theSandCharmVar", 1)
    elseif csid == 124 then
        player:setCharVar("theSandCharmVar", 3)
    elseif csid == 128 then
        player:setCharVar("SmallDialogByBlandine", 0)
    end
end

return entity
