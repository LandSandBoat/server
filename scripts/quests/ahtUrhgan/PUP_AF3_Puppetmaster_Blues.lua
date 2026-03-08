-----------------------------------
-- Puppetmaster Blues
-----------------------------------
-- Log ID: 6, Quest ID: 29
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)

quest.reward =
{
    item  = xi.item.PUPPETRY_TAJ,
    title = xi.title.PARAGON_OF_PUPPETMASTER_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME) and
                player:getMainJob() == xi.job.PUP and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(782)
                end,
            },

            onEventFinish =
            {
                [782] = function(player, csid, option, npc)
                    return quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress <= 2 then
                        return quest:event(783)
                    elseif questProgress == 3 then
                        return quest:progressEvent(784)
                    elseif questProgress == 4 then
                        return quest:event(785)
                    else
                        return quest:progressEvent(786)
                    end
                end,
            },

            onEventFinish =
            {
                [784] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [786] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(437)
                    elseif questProgress == 1 then
                        return quest:event(438)
                    elseif questProgress == 2 then
                        return quest:progressEvent(439)
                    else
                        return quest:event(440)
                    end
                end,
            },

            onEventFinish =
            {
                [437] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.VALKENGS_MEMORY_CHIP)
                    quest:setVar(player, 'Prog', 1)
                end,

                [439] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['qm8'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.TOGGLE_SWITCH)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.TOGGLE_SWITCH)
                        return quest:noAction()
                    end
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            ['Sajhra'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(291)
                    end
                end,
            },

            onEventFinish =
            {
                [291] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.TALACCA_COVE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == xi.battlefield.id.PUPPETMASTER_BLUES then
                        player:delKeyItem(xi.ki.VALKENGS_MEMORY_CHIP)
                        player:delKeyItem(xi.ki.TOGGLE_SWITCH)
                        quest:setVar(player, 'Prog', 2)
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
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    player:startEvent(787)
                end,
            },
        },
    },
}

return quest
