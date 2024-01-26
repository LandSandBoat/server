-----------------------------------
-- 75 Era Furniture Quests
-----------------------------------
require("scripts/globals/furniture_quests")
-----------------------------------
local m = Module:new("era_furniture_quests")

for itemID, furnitureQuestInformation in pairs(xi.furnitureQuests.furnitureQuestInfo) do
    if furnitureQuestInformation.waitTime ~= -1 then
        furnitureQuestInformation.waitTime = -1
    end
end

return m
