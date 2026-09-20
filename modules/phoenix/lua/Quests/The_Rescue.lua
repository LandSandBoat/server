-----------------------------------
-- Module to remove exp from 'The Rescue' quest reward, and correct the gil
-- reward to 3,000.
-- Gil and exp were added to the quest reward in 2013 so exp is removed and gil corrected here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_the_rescue', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/The_Rescue', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_THE_RANGUEMONT_PASS,
            gil     = 3000,
            title   = xi.title.HONORARY_CITIZEN_OF_SELBINA,
        }
    end)
end)
