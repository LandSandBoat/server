-----------------------------------
-- Wings of GOld
-----------------------------------
-- Log ID: 3, Quest ID: 60
-- Brutus: !gotoid 17776652
-- UPPER_DELKFUTTS_TOWER Chest !gotoid 17424564
-- MIDDLE_DELKFUTTS_TOWER: !gotoid 17420676

-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)

quest.reward =
{
    fame     = 20,
    fameArea = xi.quest.fame_area.JEUNO,
    item     = xi.items.BARBAROI_AXE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER) and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
            player:getMainJob() == xi.job.BST
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(137) -- Start Quest "Wings of gold" (Short dialog)
                    else
                        return quest:progressEvent(139) -- Start Quest "Wings of gold" (Long dialog)
                    end
                end,

            },
            onEventFinish =
            {
                [137] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 0)
                    end
                end,

                [139] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 0)
                    else
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.GUIDING_BELL) then
                        return quest:event(136)
                    else
                        return quest:progressEvent(138) -- Finish Quest "Wings of gold"
                    end
                end,
            },

            onEventFinish =
            {
                [138] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.GUIDING_BELL)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] = quest:event(134):importantOnce(),
        },
    },
}

return quest
