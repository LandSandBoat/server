-----------------------------------
-- A Fluttery Fiend
-----------------------------------
-- !addquest 8 174
-- Cavernous Maw    : !pos -344.396 -24.941 52.581 118
-- Itzpapalotl      : !spawnmob 17658277
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_FLUTTERY_FIEND)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.abyssea.getHeldTraverserStones(player) >= 1 and
                player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(62)
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and player:hasTitle(xi.title.ITZPAPALOTL_DECLAWER)
        end,

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            onZoneIn = function(player, prevZone)
                return 63
            end,

            onEventUpdate =
            {
                [63] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.abyssea.getZoneKIReward(player))
                    end
                end,
            },

            onEventFinish =
            {
                [63] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.abyssea.getZoneKIReward(player))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
