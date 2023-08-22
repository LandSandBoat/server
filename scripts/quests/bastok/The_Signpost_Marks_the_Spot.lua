-----------------------------------
-- The Signpost Marks the Spot
-----------------------------------
-- Log ID: 1, Quest ID: 22
-- Nbu Latteh : !pos -114.777 -4 -113.301 235
-- Roh Latteh : !pos -11.823 6.999 -9.249 234
-- Signpost   : !pos -183 65 599 108
-----------------------------------
local konschtatID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT)

quest.reward =
{
    item     = xi.item.LINEN_ROBE,
    fame     = 50,
    fameArea = xi.quest.fame_area.BASTOK,
    title    = xi.title.TREASURE_SCAVENGER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 2 and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.MOM_THE_ADVENTURER)
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Nbu_Latteh'] = quest:progressEvent(235),

            onEventFinish =
            {
                [235] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['Signpost'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.PAINTING_OF_A_WINDMILL) then
                        player:messageSpecial(konschtatID.text.SIGNPOST_DIALOG_2)

                        return quest:keyItem(xi.ki.PAINTING_OF_A_WINDMILL)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Roh_Latteh'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.PAINTING_OF_A_WINDMILL) then
                        return quest:progressEvent(96)
                    end
                end,
            },

            onEventFinish =
            {
                [96] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.PAINTING_OF_A_WINDMILL)
                    end
                end,
            },
        },
    },
}

return quest
