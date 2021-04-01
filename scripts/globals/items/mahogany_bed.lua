-----------------------------------
-- ID: 4
-- Item: Mahogany Bed
-----------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------
local item_object = {}

item_object.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC) == QUEST_AVAILABLE then
        player:setCharVar("[MS2]BedPlaced", 1)
    end
end

item_object.onFurnitureRemoved = function(player)
    player:setCharVar("[MS2]BedPlaced", 0)
end

return item_object
