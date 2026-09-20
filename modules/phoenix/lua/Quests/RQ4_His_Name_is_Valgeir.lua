-----------------------------------
-- Module to remove exp, gil, and fame from 'His Name is Valgeir' quest reward.
-- Gil and exp were added to the quest reward in 2013 so they are removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_rq4_his_name_is_valgeir', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/RQ4_His_Name_is_Valgeir', function(quest)
        quest.reward = {
            keyItem = xi.keyItem.MAP_OF_THE_TORAIMARAI_CANAL,
        }

        quest.sections[2][xi.zone.MHAURA].onEventFinish[88] = function(player, csid, option, npc)
            if quest:complete(player) then
                quest:setVar(player, 'DayCompleted', VanadielUniqueDay())
            end
        end
    end)
end)
