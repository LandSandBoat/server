-----------------------------------
-- Moment of Truth: Quest 6 30
-- Mishhar, Whitegate , !pos -12 -6 29 50
-- QM7, Mamook, !pos 216.861,-26.141,-94.554 65
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.MOMENT_OF_TRUTH)

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.GIVE_PEACE_A_CHANCE) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mishhar'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(800)
                end,
            },

            onEventFinish =
            {
                [800] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mishhar'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    if questProgress == 0 then
                        return quest:event(801)
                    elseif questProgress == 1 then
                        return quest:progressEvent(803)
                    elseif questProgress == 2 then
                        return quest:event(588)
                    elseif
                        questProgress == 3 or
                        questProgress == 4
                    then
                        return quest:event(804)
                    elseif questProgress == 5 then
                        return quest:progressEvent(805)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [5] = function(player, region)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(802)
                    end
                end,
            },

            onEventFinish =
            {
                [802] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [803] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [805] = function(player, csid, option, npc)
                    local jobRewardItems =
                    {
                        [xi.job.WAR] = xi.item.STRENGTH_POTION,
                        [xi.job.MNK] = xi.item.STRENGTH_POTION,
                        [xi.job.DRK] = xi.item.STRENGTH_POTION,
                        [xi.job.DRG] = xi.item.STRENGTH_POTION,

                        [xi.job.WHM] = xi.item.MIND_POTION,

                        [xi.job.BLM] = xi.item.INTELLIGENCE_POTION,
                        [xi.job.SCH] = xi.item.INTELLIGENCE_POTION,

                        [xi.job.RDM] = xi.item.VILE_ELIXIR_P1,
                        [xi.job.BLU] = xi.item.VILE_ELIXIR_P1,

                        [xi.job.THF] = xi.item.HERMES_QUENCHER,
                        [xi.job.PLD] = xi.item.VITALITY_POTION,

                        [xi.job.BST] = xi.item.CHARISMA_POTION,
                        [xi.job.BRD] = xi.item.CHARISMA_POTION,
                        [xi.job.DNC] = xi.item.CHARISMA_POTION,

                        [xi.job.RNG] = xi.item.AGILITY_POTION,
                        [xi.job.NIN] = xi.item.AGILITY_POTION,
                        [xi.job.COR] = xi.item.AGILITY_POTION,

                        [xi.job.SAM] = xi.item.ICARUS_WING,
                        [xi.job.SMN] = xi.item.PRO_ETHER_P1,
                        [xi.job.PUP] = xi.item.DEXTERITY_POTION,
                    }

                    local playerjob = player:getMainJob()
                    local rewardItem = jobRewardItems[playerjob]

                    if npcUtil.giveItem(player, rewardItem) then
                        quest:complete(player)
                    end
                end,
            },
        },

        [xi.zone.MAMOOK] =
        {
            ['qm7'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressCutscene(221)
                    end
                end,
            },

            onEventFinish =
            {
                [221] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.JADE_SEPULCHER] =
        {
            ['_1v0'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.MOMENT_OF_TRUTH then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mishhar'] = quest:event(806):replaceDefault(),
        },
    },
}

return quest
