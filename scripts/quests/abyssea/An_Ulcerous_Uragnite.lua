-----------------------------------
-- An Ulcerous Uragnite
-----------------------------------
-- !addquest 8 178
-- Cavernous Maw    : !pos -78.000 -0.500 600.000 106
-- Amphitrite       : !spawnmob 17818054
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.abyssea.getHeldTraverserStones(player) >= 1 and
                player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTH_GUSTABERG] =
        {
            ['Cavernous_Maw_2'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(0)
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and player:hasTitle(xi.title.AMPHITRITE_SHUCKER)
        end,

        [xi.zone.NORTH_GUSTABERG] =
        {
            onZoneIn = function(player, prevZone)
                return 1
            end,

            onEventUpdate =
            {
                [1] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.abyssea.getZoneKIReward(player))
                    end
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.abyssea.getZoneKIReward(player))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
