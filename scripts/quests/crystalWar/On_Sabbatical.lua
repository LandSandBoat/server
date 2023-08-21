-----------------------------------
-- On Sabbatical
-----------------------------------
-- !addquest 7 32
-- Erlene                : !pos 376.936 -39.999 17.914 175
-- Gentle Tiger          : !pos -203.932 -9.998 2.237 87
-- Indescript Markings   : !pos -456.707 24.4385 -363.364 90
-----------------------------------
local pashhowID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL)

quest.reward =
{
    item = xi.item.KLIMAFORM_SCHEMA
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.SCH and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Erlene'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(18)
                end
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ULBRECHTS_SEALED_LETTER)
                    quest:begin(player)
                end,
            }
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(46)
                    else
                        return quest:progressEvent(47)
                    end
                end
            },

            onEventFinish =
            {
                [46] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            }
        },

        [xi.zone.PASHHOW_MARSHLANDS_S] =
        {
            ['Indescript_Markings'] =
            {
                onTrigger = function(player, npc)
                    local offset = npc:getID() - pashhowID.npc.INDESCRIPT_MARKINGS_OFFSET
                    if offset == 0 and quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SCHULTZS_SEALED_LETTER)
                    quest:setVar(player, 'Prog', 2)
                end,
            }
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS_S] =
        {
            ['Erlene'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(20)
                    end

                    return quest:progressEvent(19)
                end
            },
            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ULBRECHTS_SEALED_LETTER)
                        player:delKeyItem(xi.ki.SCHULTZS_SEALED_LETTER)
                        xi.quest.setVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL)
                    end
                end,
            }
        }
    },
}

return quest
