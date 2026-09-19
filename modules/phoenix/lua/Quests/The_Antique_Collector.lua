-----------------------------------
-- Module to remove exp, gil, and fame from 'The Antique Collector' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_the_antique_collector', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/The_Antique_Collector', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_DELKFUTTS_TOWER,
            title   = xi.title.TRADER_OF_ANTIQUITIES,
        }
    end)
end)
