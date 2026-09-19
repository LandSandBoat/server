-----------------------------------
-- Module to remove exp from 'Unforgiven' quest reward.
-- Exp was added to the quest reward in 2013 so it is removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_unforgiven', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/Unforgiven', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_TAVNAZIA,
        }
    end)
end)
