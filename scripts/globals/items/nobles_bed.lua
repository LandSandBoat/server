-----------------------------------
-- ID: 6
-- Item: Noble's Bed
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD) == QUEST_AVAILABLE then
        player:setCharVar("Quest[4][102]bedPlacedTime", os.time())
        player:setLocalVar("Quest[4][102]mustZone", 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    player:setCharVar("Quest[4][102]bedPlacedTime", 0)
end

return itemObject
