-----------------------------------
-- Module to remove exp and gil from 'Paradise Salvation and Maps' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_paradise_salvation_and_maps', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/Paradise_Salvation_and_Maps', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_THE_SACRARIUM,
        }
    end)
end)
