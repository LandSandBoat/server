-----------------------------------
-- Endeavoring to Awaken
-- RUN AF Quest 2
-- !addquest 9 22
-- Octavien       : !pos 100.580 -40.150 -63.830 257
-- Zurko-Bazurko  : !pos 333.500 -13.010 -400.000 259 (Rala Waterways U)
-- Reward: 3000 Bayld
-- NOTE: Sverdheid NM does not exist in mob_spawn_points yet.
--       Quest simplified to single NM fight (Zurko-Bazurko) until Sverdheid is added.
-----------------------------------
local ralaID = zones[xi.zone.RALA_WATERWAYS_U]
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.ENDEAVORING_TO_AWAKEN)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    bayld    = 3000,
    fame     = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.CHILDREN_OF_THE_RUNE) == xi.questStatus.QUEST_COMPLETED and
                player:getMainLvl() >= 66 and
                player:getMainJob() == xi.job.RUN
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: Your rune fencing has progressed well. But there is more to learn.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Octavien: Travel to the Rala Waterways and seek out Yeggha Dolashi.', xi.msg.channel.NS_SAY)
                    npcUtil.giveKeyItem(player, xi.ki.EPHEMERAL_ENDEAVOR)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 0
        end,

        [xi.zone.RALA_WATERWAYS_U] =
        {
            ['Zurko-Bazurko'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        player:printToPlayer('The spirit fades... Your runic power has awakened!', xi.msg.channel.NS_SAY)
                    end
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: Seek out the trial in Rala Waterways.', xi.msg.channel.NS_SAY)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 1
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: You have passed the trial! Your runic power grows.', xi.msg.channel.NS_SAY)
                    player:delKeyItem(xi.ki.EPHEMERAL_ENDEAVOR)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
