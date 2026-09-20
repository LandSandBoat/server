-----------------------------------
-- Module to remove exp and gil from 'Go Go Gobmuffin' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_go_go_gobmuffin', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/Go_Go_Gobmuffin', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_CAPE_RIVERNE,
        }
    end)
end)
