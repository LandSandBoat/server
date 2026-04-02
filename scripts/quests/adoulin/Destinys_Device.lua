-----------------------------------
-- Destiny's Device
-- RUN AF Quest 5
-- !addquest 9 25
-- Octavien : !pos 100.580 -40.150 -63.830 257
-- Insidio  : !pos 465.138 -1.813 -356.476 262 (Foret de Hennetiel)
-- Reward: Runeist Coat
-----------------------------------
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.DESTINYS_DEVICE)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    item     = xi.item.RUNEIST_COAT,
    fame     = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.LEGACIES_LOST_AND_FOUND) == xi.questStatus.QUEST_COMPLETED and
                player:getMainJob() == xi.job.RUN
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: Your final trial awaits. A creature called Insidio lurks in Foret de Hennetiel.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Octavien: Defeat it and return to me.', xi.msg.channel.NS_SAY)
                    npcUtil.giveKeyItem(player, xi.ki.RUNIC_KINEGRAVER)
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

        [xi.zone.FORET_DE_HENNETIEL] =
        {
            ['Insidio'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        player:printToPlayer('Insidio has been vanquished! Return to Octavien.', xi.msg.channel.NS_SAY)
                    end
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: Defeat Insidio in Foret de Hennetiel.', xi.msg.channel.NS_SAY)
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
                    player:printToPlayer('Octavien: You have proven yourself a true Rune Fencer!', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Octavien: Take this Runeist Coat. May it serve you well.', xi.msg.channel.NS_SAY)
                    player:delKeyItem(xi.ki.RUNIC_KINEGRAVER)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
