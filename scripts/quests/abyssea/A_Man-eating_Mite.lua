-----------------------------------
-- A Man-eating Mite
-----------------------------------
-- !addquest 8 177
-- Cavernous Maw    : !pos 270.000 -9.000 -70.000 112
-- Resheph          : !spawnmob 17813913
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_MAN_EATING_MITE)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.abyssea.getHeldTraverserStones(player) >= 1 and
                player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.XARCABARD] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(58)
                end,
            },

            onEventFinish =
            {
                [58] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and player:hasTitle(xi.title.RESHEPH_ERADICATOR)
        end,

        [xi.zone.XARCABARD] =
        {
            onZoneIn = function(player, prevZone)
                return 59
            end,

            onEventUpdate =
            {
                [59] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.abyssea.getZoneKIReward(player))
                    end
                end,
            },

            onEventFinish =
            {
                [59] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.abyssea.getZoneKIReward(player))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
