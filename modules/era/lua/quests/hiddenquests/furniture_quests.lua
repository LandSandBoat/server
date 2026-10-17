-----------------------------------
-- Furniture Quests
-- Restores the Conquest wait before a reward is handed over.
-- The February 19th 2015 version update shortened the wait to 3mins per captures.
-- The following items were changed:  Oak Bed, Simple Bed, Tarutaru Desk, Bureau, Armoire, Water Cask, Lines and Space, White Jar, Wicker Box, and Stationery Set
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/46068
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_furniture_quests', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    -----------------------------------
    -- Setting Armoire to NextConquestTally
    -----------------------------------
    xi.module.modifyInteractionEntry('scripts/quests/hiddenQuests/FurnitureQuest_Armoire', function(quest)
        local anyZoneId    = xi.moghouse.moghouseZones[1]
        local zoneSection  = quest.sections[2][anyZoneId]
        local baseOnPlaced = zoneSection.armoire.onFurniturePlaced

        zoneSection.armoire.onFurniturePlaced = function(player, item)
            baseOnPlaced(player, item)
            quest:setVar(player, 'RewardReadyTime', NextConquestTally())
        end
    end)
end)
