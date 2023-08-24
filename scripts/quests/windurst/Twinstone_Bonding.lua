-----------------------------------
-- Twinstone Bonding
-----------------------------------
-- !addquest 2 62
-- Gioh Ajirhri : !pos 107 -5 174 241
-----------------------------------
require('scripts/globals/interaction/quest')
require("scripts/globals/npc_util")
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')

-----------------------------------
local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)

quest.sections =
{
    -- Quest Acceptance
    {
        check = function(player, status, vars)
            return
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2 and
                status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Gioh_Ajihri'] = quest:progressEvent(487, 0, xi.items.TWINSTONE_EARRING),

            onEventFinish =
            {
                [487] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Quest Initial Completion
    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Gioh_Ajihri'] =
            {
                onTrigger = function(player, npc)
                    local item = xi.items.TWINSTONE_EARRING
                    if player:needToZone() then
                        return quest:event(491, 0, item)
                    end

                    return quest:progressEvent(488, 0, item)
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        not player:needToZone() and
                        npcUtil.tradeHasExactly(trade, { { xi.items.TWINSTONE_EARRING, 1 } })
                    then
                        return quest:progressEvent(490)
                    end
                end
            },

            onEventFinish =
            {
                [488] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [490] = function(player, csid, option, npc)
                    if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_COMPLETED then
                        -- rewards for repeat completion
                        quest.reward =
                        {
                            fame = 10,
                            fameArea = xi.quest.fame_area.WINDURST,
                            gil = 900 * xi.settings.main.GIL_RATE
                        }
                    else
                        -- rewards for first completion
                        quest.reward =
                        {
                            fame = 80,
                            fameArea = xi.quest.fame_area.WINDURST,
                            item = xi.items.WRAPPED_BOW,
                            title = xi.title.BOND_FIXER
                        }
                    end

                    if quest:complete(player) then
                        player:confirmTrade()
                        player:needToZone(true)
                    end
                end
            },
        },
    },
}

return quest
