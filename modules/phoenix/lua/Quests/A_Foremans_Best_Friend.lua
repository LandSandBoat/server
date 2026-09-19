-----------------------------------
-- Module to remove the exp compensation given by 'A Foreman's Best Friend' when the
-- player already holds the map key item.
-- Exp was added in 2013 so it is removed here.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_a_foremans_best_friend', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/bastok/A_Foremans_Best_Friend', function(quest)
        quest.sections[2][xi.zone.PORT_BASTOK].onEventFinish[112] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:tradeComplete()
                if not player:hasKeyItem(xi.keyItem.MAP_OF_THE_GUSGEN_MINES) then
                    npcUtil.giveKeyItem(player, xi.keyItem.MAP_OF_THE_GUSGEN_MINES)
                end
            end
        end
    end)
end)
