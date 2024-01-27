-----------------------------------
-- Module to make 'Mom the Adventurer?' quest missable.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('missable_mom_the_adventurer')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/bastok/Mom_the_Adventurer', function(quest)
        quest.sections[1].check = function(player, status, vars)
            return status ~= QUEST_ACCEPTED and
                player:getFameLevel(xi.quest.fame_area.BASTOK) < 2 and
                vars.Prog == 0
        end
    end)
end)

return m
