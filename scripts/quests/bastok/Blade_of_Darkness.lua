-----------------------------------
-- Blade of Darkness
-----------------------------------
-- Log ID: 1, Quest ID: 28
-- Gumbah : !pos 52 0 -36 234
-- TODO: This quest needs verification!
-----------------------------------
local beadeauxID = zones[xi.zone.BEADEAUX]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    title    = xi.title.DARK_SIDER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Gumbah'] = quest:progressEvent(99),

            onEventFinish =
            {
                [99] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ZERUHN_MINES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.PALBOROUGH_MINES then
                        if quest:getVar(player, 'Prog') == 0 then
                            return 130
                        elseif not player:hasItem(xi.item.CHAOSBRINGER) then
                            return 131
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [130] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CHAOSBRINGER) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [131] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.item.CHAOSBRINGER)
                end,
            },
        },

        [xi.zone.BEADEAUX] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.PASHHOW_MARSHLANDS and
                        player:getCharVar('ChaosbringerKills') >= 100
                    then
                        return 121
                    end
                end,
            },

            onEventFinish =
            {
                [121] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:unlockJob(xi.job.DRK)
                        player:messageSpecial(beadeauxID.text.YOU_CAN_NOW_BECOME_A_DARK_KNIGHT)
                    end
                end,
            },
        },
    },
}

return quest
