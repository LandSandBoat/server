-----------------------------------
-- The Sacred Katana (SAM AF1)
-----------------------------------
-- Log ID: 5, Quest ID: 140
-- Jaucribaix      : !pos 91 -7 -8 252
-- Ranemaud        : !pos 15 0 23 252
-- qm3 (Zi'Tah)    : !pos -416 0 46 121
-----------------------------------
local zitahID = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA)

quest.reward =
{
    fame = 20,
    fameArea = xi.fameArea.NORG,
    item = xi.item.MAGOROKU,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.FORGE_YOUR_DESTINY) and
                player:getMainJob() == xi.job.SAM and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] = quest:progressEvent(139),

            onEventFinish =
            {
                [139] = function(player, csid, option, npc)
                    if option == 1 then
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

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:hasKeyItem(xi.ki.HANDFUL_OF_CRYSTAL_SCALES) and
                        npcUtil.tradeMatches(trade, { { xi.item.MUMEITO, 1 } })
                    then
                        return quest:progressEvent(141)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(player:findItem(xi.item.MUMEITO) and 140 or 143)
                end,
            },

            ['Ranemaud'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:findItem(xi.item.MUMEITO) and
                        npcUtil.tradeMatches(trade, { { xi.item.GIL, 30000 } })
                    then
                        return quest:progressEvent(145)
                    end
                end,

                onTrigger = function(player, npc)
                    if not player:findItem(xi.item.MUMEITO) then
                        return quest:event(144)
                    end
                end,
            },

            onEventFinish =
            {
                [139] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,

                [141] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:delKeyItem(xi.ki.HANDFUL_OF_CRYSTAL_SCALES)

                        -- Player must zone before being able to flag the next quest
                        xi.quest.setMustZone(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI)
                        xi.quest.setVar(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI, 'Timer', GetSystemTime() + 60) -- 1 minute wait time
                    end
                end,

                [145] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.MUMEITO) then
                        player:tradeComplete()
                    end
                end,
            },
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Isonade'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setLocalVar(player, 'Prog', 1)
                end,
            },

            ['qm3'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeMatches(trade, { { xi.item.SACK_OF_FISH_BAIT, 1 } }) and
                        npcUtil.popFromQM(player, npc, zitahID.mob.ISONADE, { hide = 0 })
                    then
                        player:tradeComplete()
                        return quest:messageSpecial(zitahID.text.SENSE_OF_FOREBODING)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        quest:getLocalVar(player, 'Prog') == 1 and
                        not player:hasKeyItem(xi.ki.HANDFUL_OF_CRYSTAL_SCALES)
                    then
                        return quest:keyItem(xi.ki.HANDFUL_OF_CRYSTAL_SCALES)
                    end
                end,
            },
        },
    },
}

return quest
