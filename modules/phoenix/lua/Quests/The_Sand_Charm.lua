-----------------------------------
-- Module to remove exp, gil, and fame from 'The Sand Charm' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_the_sand_charm', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/The_Sand_Charm', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_BOSTAUNIEUX_OUBLIETTE,
        }
    end)
end)
