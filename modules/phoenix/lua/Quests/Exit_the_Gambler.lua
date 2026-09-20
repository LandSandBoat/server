-----------------------------------
-- Module to remove exp, gil, and fame from 'Exit the Gambler' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_exit_the_gambler', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Exit_the_Gambler', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_KING_RANPERRES_TOMB,
            title   = xi.title.DAYBREAK_GAMBLER,
        }
    end)
end)
