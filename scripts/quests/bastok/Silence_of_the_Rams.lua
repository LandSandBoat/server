-----------------------------------
-- Silence of the Rams
-----------------------------------
-- Log ID: 1, Quest ID: 48
-- Paujean : !pos -93.738 4.649 34.373 236
-----------------------------------
local portBastokID = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.SILENCE_OF_THE_RAMS)

quest.reward =
{
    fame     = 20,
    fameArea = xi.fameArea.NORG,
    item     = xi.item.PURPLE_BELT,
    title    = xi.title.PURPLE_BELT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.NORG) >= 2
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Paujean'] = quest:progressEvent(195),

            onEventFinish =
            {
                [195] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Paujean'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.LUMBERING_HORN, 1 }, { xi.item.RAMPAGING_HORN, 1 } }) then
                        return quest:progressEvent(196)
                    end
                end,

                onTrigger = quest:messageName(portBastokID.text.PAUJEAN_DIALOG_1),
            },

            onEventFinish =
            {
                [196] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                    end
                end,
            },
        },
    },
}

return quest
