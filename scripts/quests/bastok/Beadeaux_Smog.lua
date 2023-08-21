-----------------------------------
-- Beadeaux Smog
-----------------------------------
-- Log ID: 1, Quest ID: 33
-- High Bear    : !pos 25.231 -14.999 4.552 237
-- qm1 (for KI) : !pos -58.873 1.026 -116.665 147
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEADEAUX_SMOG)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    title = xi.title.BEADEAUX_SURVEYOR,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.BASTOK) >= 4
        end,

        [xi.zone.METALWORKS] =
        {
            ['High_Bear'] = quest:progressEvent(731),

            onEventFinish =
            {
                [731] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and not player:hasKeyItem(xi.keyItem.CORRUPTED_DIRT)
        end,

        -- While the quest is accepted, High Bear uses his default text

        [xi.zone.BEADEAUX] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    return quest:keyItem(xi.ki.CORRUPTED_DIRT)
                end,
            },
        },
    },

    -- Section: Hand in quest
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and player:hasKeyItem(xi.keyItem.CORRUPTED_DIRT)
        end,

        [xi.zone.METALWORKS] =
        {
            ['High_Bear'] = quest:progressEvent(732),

            onEventFinish =
            {
                [732] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CHAKRAM) then
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
