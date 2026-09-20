-----------------------------------
-- Module to remove exp and fame from 'Glyph Hanger' quest reward.
-- Exp was added to the quest reward in 2013 so it is removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_glyph_hanger', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/windurst/Glyph_Hanger', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_THE_HORUTOTO_RUINS,
        }
    end)
end)
