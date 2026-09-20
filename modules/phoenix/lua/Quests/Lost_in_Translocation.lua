-----------------------------------
-- Module to remove exp and gil from 'Lost in Translocation' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_lost_in_translocation', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/crystalWar/Lost_in_Translocation', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_GRAUBERG,
        }
    end)
end)
