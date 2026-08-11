-----------------------------------
-- Module to remove exp and gil from 'Northward' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/38100
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_northward', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Northward', function(quest)
        quest.reward = {
            keyItem  = xi.ki.MAP_OF_CASTLE_ZVAHL,
            title    = xi.title.ENVOY_TO_THE_NORTH,
        }
    end)
end)
