-----------------------------------
-- Module to remove exp and fame from 'The Bare Bones' quest reward.
-- Exp was added to the quest reward in 2013 so it is removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_the_bare_bones', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/bastok/The_Bare_Bones', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_THE_DANGRUF_WADI,
        }
    end)
end)
