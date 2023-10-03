-----------------------------------
-- Allow WOTG Missions to be completed without the accompanying WOTG Nation Quests
-----------------------------------
require('modules/module_utils')
require('scripts/missions/wotg/helpers')
-----------------------------------
local m = Module:new('wotg_decouple_story_missions_from_nation_quests')

-- WOTG3: Cait Sith
m:addOverride('xi.wotg.helpers.meetsMission3Reqs', function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

-- WOTG4: The Queen of the Dance
m:addOverride('xi.wotg.helpers.meetsMission4Reqs', function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

-- WOTG8: In the Name of the Father
m:addOverride('xi.wotg.helpers.meetsMission8Reqs', function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

-- WOTG15: Crossroads of Time
m:addOverride('xi.wotg.helpers.meetsMission15Reqs', function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

-- WOTG26: Fate in Haze
m:addOverride('xi.wotg.helpers.meetsMission26Reqs', function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

-- WOTG38: Adieu, Lilisette
m:addOverride('xi.wotg.helpers.meetsMission38Reqs', function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

return m
