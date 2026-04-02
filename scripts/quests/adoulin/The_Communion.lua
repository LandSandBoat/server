-----------------------------------
-- The Communion
-- GEO AF Quest 5
-- !addquest 9 38
-- Sylvie          : !pos 78.094 32.000 135.725 256
-- Overgrown_Grave : !pos 455.093 9.880 102.513 270
-- Ancestral_Rage  : !pos 453.803 9.135 102.766 270
-- Reward: Geomancy Pants
-----------------------------------
local cirdasID = zones[xi.zone.CIRDAS_CAVERNS]
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_COMMUNION)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    item     = xi.item.GEOMANCY_PANTS,
    fame     = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_BLOODLINE_OF_ZACARIAH) == xi.questStatus.QUEST_COMPLETED and
                player:getMainJob() == xi.job.GEO
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: There is one final trial you must undertake.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Sylvie: Return to the Overgrown Grave in Cirdas Caverns. An ancient spirit awaits.', xi.msg.channel.NS_SAY)
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

        [xi.zone.CIRDAS_CAVERNS] =
        {
            ['Overgrown_Grave'] =
            {
                onTrigger = function(player, npc)
                    if npcUtil.popFromQM(player, npc, cirdasID.mob.ANCESTRAL_RAGE, { claim = true, look = true }) then
                        player:printToPlayer('The grave shudders... An ancient geomantic spirit manifests!', xi.msg.channel.NS_SAY)
                    else
                        player:printToPlayer('The area is too dangerous right now. Try again later.', xi.msg.channel.NS_SAY)
                    end
                end,
            },

            ['Ancestral_Rage'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        player:printToPlayer('The spirit fades peacefully... It acknowledges your mastery.', xi.msg.channel.NS_SAY)
                    end
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: Visit the Overgrown Grave in Cirdas Caverns for your final trial.', xi.msg.channel.NS_SAY)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 1
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: You communed with the ancestral spirit! Your geomantic power is now complete.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Sylvie: Take these Geomancy Pants. You have truly mastered the art.', xi.msg.channel.NS_SAY)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
