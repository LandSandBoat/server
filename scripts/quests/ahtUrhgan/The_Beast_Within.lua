-----------------------------------
-- The Beast Within (BLU 75 Cap )
-----------------------------------
-- Log ID: 6, Quest ID: 40
-- Waoud              : !pos 65 -6 -78 50
-- Imperial Whitegate : !pos 154.296 -4.199 0.3 50
-----------------------------------
require('scripts/globals/bcnm')
require('scripts/globals/interaction/quest')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
-----------------------------------
local sepulcherID = require("scripts/zones/Jade_Sepulcher/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN)

quest.reward =
{
    title = xi.title.MASTER_OF_AMBITION,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS) and
                player:getMainJob() == xi.job.BLU and
                player:getMainLvl() >= 66
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Waoud'] =
            {
                onTrigger = function(player, npc)
                    local lastDivination = xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS, 'Timer')
                    if
                        lastDivination <= VanadielUniqueDay() and
                        not quest:getMustZone(player)
                    then
                        return quest:progressEvent(760, xi.items.BLUE_MAGES_TESTIMONY)
                    end
                end,
            },

            onEventFinish =
            {
                [760] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            player:getMainJob() == xi.job.BLU and
            player:getMainLvl() >= 66
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.items.BLUE_MAGES_TESTIMONY) then
                        return quest:progressEvent(762)
                    end
                end,
            },

            onEventFinish =
            {
                [762] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:tradeComplete(false)
                    player:setPos(300, -0.853, -177.745, 60, 67) -- Jade Sepulcher
                end,
            },
        },

        [xi.zone.JADE_SEPULCHER] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog')  == 2 then
                        return 2
                    elseif quest:getVar(player, 'Prog')  == 4 then
                        return 6
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [6] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        if player:getLevelCap() == 70 then
                            player:setLevelCap(75)
                            player:messageSpecial(sepulcherID.text.LIMIT_75)
                        end
                    end
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 1154 then
                        quest:setVar(player, 'Prog', 4)
                        player:setPos(260, -8.511, -236.031, 191, 67)
                    end
                end,
            },
        },
    },
}

return quest
