-----------------------------------
-- ID: 5
-- Item: Bronze Bed
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK) == QUEST_AVAILABLE then
        player:setCharVar("Quest[4][100]bedPlacedTime", os.time())
        player:setLocalVar("Quest[4][100]mustZone", 1)
    end
end

itemObject.onFurnitureRemoved = function(player)
    player:setCharVar("Quest[4][100]bedPlacedTime", 0)
end

return itemObject
