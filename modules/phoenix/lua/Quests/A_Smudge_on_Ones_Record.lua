-----------------------------------
-- Module to remove exp and fame from 'A Smudge on One's Record' quest reward, and
-- correct the gil reward to 3,000.
-- Gil and exp were added to the quest reward in 2013 so exp is removed and gil corrected here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_a_smudge_on_ones_record', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/windurst/A_Smudge_on_Ones_Record', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_FEIYIN,
            gil     = 3000,
        }
    end)
end)
