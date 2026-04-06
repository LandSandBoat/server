-----------------------------------
-- Puppetmaster Blues
-- PUP AF Quest 3
-- !addquest 6 29
-- Iruki-Waraki : !pos 101.329 -6.999 -29.042 50
-- Reward: Puppetry Taj (head)
-----------------------------------
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES)

quest.reward =
{
    fameArea = xi.fameArea.NORG,
    item     = xi.item.PUPPETRY_TAJ,
    title    = xi.title.PARAGON_OF_PUPPETMASTER_EXCELLENCE,
    fame     = 30,
}

quest.sections =
{
    -- Section 1: Quest available — must be PUP, AF3 level, AF2 complete
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME) == xi.questStatus.QUEST_COMPLETED and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
                player:getMainJob() == xi.job.PUP
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Iruki-Waraki: My masterrr has been acting strangely lately...', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Iruki-Waraki: Please speak with Shamarhaan in Bastok Markets.', xi.msg.channel.NS_SAY)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section 2: Accepted — go talk to Shamarhaan in Bastok Markets
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Iruki-Waraki: Please visit Shamarhaan in Bastok Markets.', xi.msg.channel.NS_SAY)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Shamarhaan: So you are the one Iruki-Waraki told me about.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Shamarhaan: Take this memory chip. It belonged to an automaton named Valkeng.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Shamarhaan: Retrieve the toggle switch from Mount Zhayolm, then face Valkeng in Talacca Cove.', xi.msg.channel.NS_SAY)
                    npcUtil.giveKeyItem(player, xi.ki.VALKENGS_MEMORY_CHIP)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section 3: Have memory chip — get toggle switch from Mount Zhayolm ???
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Iruki-Waraki: Shamarhaan asked you to go to Mount Zhayolm, yes?', xi.msg.channel.NS_SAY)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Shamarhaan: Search Mount Zhayolm for the toggle switch, then enter Talacca Cove.', xi.msg.channel.NS_SAY)
                end,
            },
        },

        [xi.zone.MOUNT_ZHAYOLM] =
        {
            ['Valkeng'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TOGGLE_SWITCH) then
                        player:printToPlayer('You find a strange device among the wreckage...', xi.msg.channel.NS_SAY)
                        npcUtil.giveKeyItem(player, xi.ki.TOGGLE_SWITCH)
                        quest:setVar(player, 'Prog', 2)
                    else
                        player:printToPlayer('There is nothing more to find here.', xi.msg.channel.NS_SAY)
                    end
                end,
            },
        },
    },

    -- Section 4: Have both KIs — enter Talacca Cove battlefield and defeat Valkeng
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 2
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Iruki-Waraki: Head to Talacca Cove and face Valkeng!', xi.msg.channel.NS_SAY)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Shamarhaan'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Shamarhaan: You have what you need. Enter Talacca Cove and defeat Valkeng.', xi.msg.channel.NS_SAY)
                end,
            },
        },

        [xi.zone.TALACCA_COVE] =
        {
            ['Valkeng'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3)
                        player:delKeyItem(xi.ki.VALKENGS_MEMORY_CHIP)
                        player:delKeyItem(xi.ki.TOGGLE_SWITCH)
                        player:printToPlayer('Valkeng has been defeated! Return to Iruki-Waraki.', xi.msg.channel.NS_SAY)
                    end
                end,
            },
        },
    },

    -- Section 5: Defeated Valkeng — return to Iruki-Waraki for reward
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 3
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Iruki-Waraki'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Iruki-Waraki: You defeated Valkeng?! Masterrr Shamarhaan will be so pleased!', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Iruki-Waraki: Please take this as a token of our gratitude!', xi.msg.channel.NS_SAY)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
