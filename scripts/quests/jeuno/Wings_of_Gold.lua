-----------------------------------
-- Wings of GOld
-----------------------------------
-- Log ID: 3, Quest ID: 60
-- Brutus                      : !gotoid 17776652
-- UPPER_DELKFUTTS_TOWER Chest : !gotoid 17424564
-- MIDDLE_DELKFUTTS_TOWER      : !gotoid 17420676
-----------------------------------
local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.JEUNO,
    item     = xi.item.BARBAROI_AXE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER) and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
                player:getMainJob() == xi.job.BST
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(139)
                    else
                        return quest:progressEvent(137)
                    end
                end,

            },
            onEventFinish =
            {
                [137] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,

                [139] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Prog', 1) -- If declined then future Brutus quest start will use short dialog
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.GUIDING_BELL) then
                        return quest:event(136)
                    else
                        return quest:progressEvent(138)
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
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] = quest:event(134):importantOnce(),
        },
    },
}

return quest
