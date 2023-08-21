-----------------------------------
-- Atop the Highest Mountains
-----------------------------------
-- Log ID: 3, Quest ID: 129
-- Maat : !pos 8 3 118 243
-- Xarcabard
-- qm2 : !pos 341 -29 370 112
-- qm3 : !pos 580 -9 290 112
-- qm4 : !pos -21 -25 -490 112
-----------------------------------
local ruludeID    = zones[xi.zone.RULUDE_GARDENS]
local xarcabardID = zones[xi.zone.XARCABARD]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS)

quest.reward =
{
    fame = 40,
    fameArea = xi.quest.fame_area.JEUNO,
    title = xi.title.SUMMIT_BREAKER,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getLevelCap() == 55 and
                xi.settings.main.MAX_LEVEL >= 60
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 51 then
                        return quest:progressEvent(82)
                    else
                        return quest:messageText(ruludeID.text.MAAT_LB2_PLACEHOLDER)
                    end
                end,
            },

            onEventFinish =
            {
                [82] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Maat'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.ROUND_FRIGICITE) and
                        player:hasKeyItem(xi.ki.SQUARE_FRIGICITE) and
                        player:hasKeyItem(xi.ki.TRIANGULAR_FRIGICITE)
                    then
                        return quest:progressEvent(84)
                    else
                        return quest:event(83)
                    end
                end,
            },

            onEventFinish =
            {
                [84] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ROUND_FRIGICITE)
                        player:delKeyItem(xi.ki.SQUARE_FRIGICITE)
                        player:delKeyItem(xi.ki.TRIANGULAR_FRIGICITE)
                        player:setLevelCap(60)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_60)
                    end
                end,
            },
        },

        [xi.zone.XARCABARD] =
        {
            ['qm_boreal_tiger'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.ROUND_FRIGICITE) and
                        (not xi.settings.main.OLDSCHOOL_G2 or GetMobByID(xarcabardID.mob.BOREAL_TIGER):isDead())
                    then
                        return quest:keyItem(xi.ki.ROUND_FRIGICITE)
                    end
                end,
            },

            ['qm_boreal_coeurl'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.SQUARE_FRIGICITE) and
                        (not xi.settings.main.OLDSCHOOL_G2 or GetMobByID(xarcabardID.mob.BOREAL_COEURL):isDead())
                    then
                        return quest:keyItem(xi.ki.SQUARE_FRIGICITE)
                    end
                end,
            },

            ['qm_boreal_hound'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.TRIANGULAR_FRIGICITE) and
                        (not xi.settings.main.OLDSCHOOL_G2 or GetMobByID(xarcabardID.mob.BOREAL_HOUND):isDead())
                    then
                        return quest:keyItem(xi.ki.TRIANGULAR_FRIGICITE)
                    end
                end,
            },
        },
    },
}

return quest
