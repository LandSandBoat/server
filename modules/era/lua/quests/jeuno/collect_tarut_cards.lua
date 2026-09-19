-----------------------------------
-- Collect Tarut Cards
-- Removes the extra batch of cards. Chululu gives five cards once, when the quest is accepted.
-- The July 12, 2011 version update let her hand out a new batch after each conquest tally.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/11231-July-12-2011-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_collect_tarut_cards', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Collect_Tarut_Cards', function(quest)
        quest.sections[2][xi.zone.LOWER_JEUNO]['Chululu'].onTrigger = function(player, npc)
            return quest:event(27) -- Reminder
        end
    end)
end)
