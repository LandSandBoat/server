-----------------------------------
-- The Gift
-----------------------------------
-- Log ID: 4, Quest ID: 21
-- !addquest 4 21
-- !additem 4375
-- Oswald  : !pos 47.119 -15.273 7.989 248
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_GIFT)

quest.reward =
{
    item     = xi.item.SLEEP_DAGGER,
    title    = xi.title.SAVIOR_OF_LOVE,
    fameArea = xi.fameArea.SELBINA_RABAO,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA) == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_SAND_CHARM) >= xi.questStatus.QUEST_ACCEPTED and
                xi.settings.map.FISHING_ENABLE == true
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:progressEvent(70, xi.item.DANCESHROOM), -- Girlfriend needs a shroom

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    if option == 50 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(71) -- They are really hard to come by
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.DANCESHROOM) then
                        return quest:progressEvent(72, 0, xi.item.DANCESHROOM) -- You found it! Please take this reward
                    end
                end,
            },

            onEventFinish =
            {
                [72] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SELBINA] =
        {
            ['Oswald'] = quest:progressEvent(78):replaceDefault(),
            -- I've been all over Vana'diel, but the inn is my favorite.
        },
    },
}

return quest
