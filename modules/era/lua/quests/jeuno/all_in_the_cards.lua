-----------------------------------
-- All in the Cards
-- Removes the quest. Chululu did not offer it before the July 12, 2011 version update.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/11231-July-12-2011-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_all_in_the_cards', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/All_in_the_Cards', function(quest)
        -- The first offer and the repeat offer. A player already holding the quest can still turn it in.
        quest.sections[1].check = function(player, status, vars)
            return false
        end

        quest.sections[2].check = function(player, status, vars)
            return false
        end
    end)
end)
