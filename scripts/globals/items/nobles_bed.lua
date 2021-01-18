-----------------------------------------
-- ID: 6
-- Item: Noble's Bed
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------------
local item_object = {}

item_object.onFurniturePlaced = function(player)
    if player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.MOOGLES_IN_THE_WILD) == QUEST_AVAILABLE then
        player:setCharVar("[MS3]BedPlaced", 1)
    end
end

item_object.onFurnitureRemoved = function(player)
    player:setCharVar("[MS3]BedPlaced", 0)
end

return item_object
