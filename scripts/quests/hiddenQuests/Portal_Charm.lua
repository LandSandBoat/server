-----------------------------------
-- Portal Charm
-----------------------------------
-- Kupipi : !pos 2 0.1 30 242
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------

local quest = HiddenQuest:new("portalCharm")

quest.reward =
{
    keyItem = xi.ki.PORTAL_CHARM,
}

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return player:getNation() == xi.nation.WINDURST and
                player:getRank(xi.nation.WINDURST) >= 3
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.ROLANBERRY) and
                        not player:hasKeyItem(xi.ki.PORTAL_CHARM)
                    then
                        if player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS) then
                            return quest:progressEvent(291)
                        else
                            return quest:progressEvent(292)
                        end
                    end
                end,

                onTrigger = function(player, npc, trade)
                    if
                        player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(293)
                    end
                end,
            },

            onEventFinish =
            {
                [291] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,

                [292] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                end,

                [293] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    }
}

return quest
