-----------------------------------
-- A Goldstruck Gigas
-----------------------------------
-- !addquest 8 163
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                xi.abyssea.getHeldTraverserStones(player) >= 1 and
                player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) >= QUEST_ACCEPTED
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Cavernous_Maw'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(9)
                end,
            },

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and player:hasTitle(xi.title.BRIAREUS_FELLER)
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 10
                end,
            },

            onEventUpdate =
            {
                [10] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(xi.abyssea.getZoneKIReward(player))
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    -- NOTE: Give the key item prior to completing the quest so that we reward the correct
                    -- KI!  If we complete first, it'll adjust the total completed count, and be off by one!
                    npcUtil.giveKeyItem(player, xi.abyssea.getZoneKIReward(player))
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
