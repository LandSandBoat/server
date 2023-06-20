-----------------------------------
-- Early Bird Catches the Bookworm
-----------------------------------
-- !addquest 2 20
-- Tosuka-Porika   : !pos -26 -6 103 238
-- Furakku-Norakku : !pos -19 -5 101 238
-- Orn             : !pos -68 -9 30 238
-- Quu Bokye       : !pos -159 16 181 145
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.EARLY_BIRD_CATCHES_THE_BOOKWORM)

quest.reward =
{
    fame = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    gil = 1500,
    title = xi.title.SAVIOR_OF_KNOWLEDGE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.GLYPH_HANGER) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Tosuka-Porika'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Requirements for availability need to be verified, and was referenced at the below location.  Left
                    -- in this block to make it easier to remove if it turns out to be inaccurate.
                    -- https://ffxiclopedia.fandom.com/wiki/Early_Bird_Catches_the_Bookworm
                    if
                        player:getNation() ~= xi.nation.WINDURST or
                        (not player:getCurrentMission(xi.mission.log_id.WINDURST) == xi.mission.id.windurst.LOST_FOR_WORDS and
                        not player:getCurrentMission(xi.mission.log_id.WINDURST) == xi.mission.id.windurst.THE_SIXTH_MINISTRY)
                    then
                        return quest:progressEvent(387)
                    end
                end,
            },

            onEventFinish =
            {
                [387] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Furakku-Norakku'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        if not player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATIONS_EARLY_BIRD) then
                            return quest:progressEvent(389, 0, xi.ki.ART_FOR_EVERYONE)
                        else
                            return quest:progressEvent(390, 0, xi.ki.ART_FOR_EVERYONE)
                        end
                    elseif questProgress == 1 then
                        return quest:progressEvent(397, 0, xi.ki.ART_FOR_EVERYONE)
                    elseif questProgress >= 2 then
                        return quest:progressEvent(400)
                    end
                end,
            },

            ['Orn'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 0 and
                        player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATIONS_EARLY_BIRD)
                    then
                        return quest:progressEvent(395, 0, xi.ki.ART_FOR_EVERYONE)
                    elseif questProgress == 1 then
                        return quest:progressEvent(396)
                    elseif questProgress == 2 then
                        return quest:progressEvent(398)
                    elseif questProgress == 3 then
                        return quest:progressEvent(399)
                    end
                end,
            },

            ['Tosuka-Porika'] = quest:progressEvent(388),

            onEventFinish =
            {
                [389] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.OVERDUE_BOOK_NOTIFICATIONS_EARLY_BIRD)
                end,

                [395] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [398] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [400] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLocalVar('Quest[2][13]mustZone', 1)
                        player:delKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATIONS_EARLY_BIRD)
                    end
                end,
            },
        },

        [xi.zone.GIDDEUS] =
        {
            ['Quu_Bokye'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, xi.items.SILVER_BEASTCOIN)
                    then
                        return quest:progressEvent(58)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(57)
                    elseif questProgress == 2 then
                        return quest:progressEvent(59)
                    end
                end,
            },

            onEventFinish =
            {
                [58] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.ART_FOR_EVERYONE)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                player:getLocalVar('Quest[2][13]mustZone') == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Furakku-Norakku'] = quest:event(401):replaceDefault()
        },
    },
}

return quest
