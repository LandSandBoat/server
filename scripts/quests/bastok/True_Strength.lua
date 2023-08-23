-----------------------------------
-- True Strength
-----------------------------------
-- Log ID: 1, Quest ID: 53
-- Ayame           : !pos 133 -19 34 237
-- qm_truestrength : !pos -100 -71 -132 151
-----------------------------------
local oztrojaID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH)

quest.reward =
{
    fame     = 60,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.TEMPLE_HOSE,
    title    = xi.title.PARAGON_OF_MONK_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING) and
                player:getMainJob() == xi.job.MNK and
                player:getMainLvl() >= 50
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] = quest:progressEvent(748),

            onEventFinish =
            {
                [748] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CASTLE_OZTROJA] =
        {
            ['qm_truestrength'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.BOTTLE_OF_YAGUDO_DRINK) and
                        not player:hasItem(xi.item.XALMO_FEATHER) and
                        npcUtil.popFromQM(player, npc, oztrojaID.mob.HUU_XALMO_THE_SAVAGE, { hide = 0 })
                    then
                        player:confirmTrade()

                        return quest:messageSpecial(oztrojaID.text.SENSE_OF_FOREBODING)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.XALMO_FEATHER) then
                        return quest:progressEvent(749)
                    end
                end,
            },

            onEventFinish =
            {
                [749] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
