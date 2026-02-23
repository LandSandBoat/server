-----------------------------------
-- The Beast of Bastore
-----------------------------------
-- !addquest 8 172
-- Cavernous Maw    : !pos 246.318 -0.709 5.706 104
-- Sedna            : !spawnmob 17666500
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_BEAST_OF_BASTORE)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.abyssea.getHeldTraverserStones(player) >= 1 and
                player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.JUGNER_FOREST] =
        {
            ['Cavernous_Maw_2'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(48)
                end,
            },

            onEventFinish =
            {
                [48] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and player:hasTitle(xi.title.SEDNA_TUSKBREAKER)
        end,

        [xi.zone.JUGNER_FOREST] =
        {
            onZoneIn = function(player, prevZone)
                return 49
            end,

            onEventUpdate =
            {
                [49] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.abyssea.getZoneKIReward(player))
                    end
                end,
            },

            onEventFinish =
            {
                [49] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.abyssea.getZoneKIReward(player))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
