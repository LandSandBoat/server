-----------------------------------
-- Forging New Bonds
-- RUN AF Quest 3
-- !addquest 9 23
-- Octavien  : !pos 100.580 -40.150 -63.830 257
-- Staumarth : !pos 396.500 29.520 -167.240 269 (Moh Gates)
-- Reward: Beorc Sword + unlocks Jerra Ndala commissions
-----------------------------------
local mohID = zones[xi.zone.MOH_GATES]
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.FORGING_NEW_BONDS)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    item     = xi.item.BEORC_SWORD,
    fame     = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.ENDEAVORING_TO_AWAKEN) == xi.questStatus.QUEST_COMPLETED and
                player:getMainLvl() >= 90 and
                player:getMainJob() == xi.job.RUN
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: There is a disturbance at the Molten Rift in Moh Gates.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Octavien: A creature called Staumarth threatens the area. Defeat it.', xi.msg.channel.NS_SAY)
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

        [xi.zone.MOH_GATES] =
        {
            ['Staumarth'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                        player:printToPlayer('Staumarth has been defeated! Return to Octavien.', xi.msg.channel.NS_SAY)
                    end
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: Defeat Staumarth at the Molten Rift in Moh Gates.', xi.msg.channel.NS_SAY)
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
                    player:printToPlayer('Octavien: You defeated Staumarth! Take this sword as proof of your bond.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Octavien: Jerra Ndala in Rala Waterways can now craft Runeist armor for you.', xi.msg.channel.NS_SAY)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
