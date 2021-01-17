-----------------------------------------
-- ID: 4
-- Item: Mahogany Bed
-----------------------------------------
require("scripts/globals/common")
require("scripts/globals/quests")
-----------------------------------------
local item_object = {}

function onFurniturePlaced(player)
    if player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.THE_MOOGLE_PICNIC) == QUEST_AVAILABLE then
        player:setCharVar("[MS2]BedPlaced", 1)
    end
end

function onFurnitureRemoved(player)
    player:setCharVar("[MS2]BedPlaced", 0)
end

return item_object
