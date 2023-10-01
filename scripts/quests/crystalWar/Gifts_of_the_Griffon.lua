-----------------------------------
-- Gifts of the Griffon
-----------------------------------
-- !addquest 7 15
-- Louxiard   : !pos -93 -4 49 80
-- Rholont    : !pos -168 -2 56 80
-- Elnonde    : !pos 86 2 -0 80
-- Illeuse    : !pos -44.203 2 -36.216 80
-- Loillie    : !pos 78 -8 -23 80
-- Machionage : !pos -255 -3 109 80
-- Rongelouts : !pos 0.067 2 -22 80
-- Sabiliont  : !pos 9 2 -87 80
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON)

quest.reward =
{
    item = xi.item.DEATHSTONE,
}

local npcTradeEvents =
{
    ['Elnonde']              = 30,
    ['Illeuse']              = 31,
    ['Loillie']              = 29,
    ['Louxiard']             = 26,
    ['Machionage']           = 28,
    ['Rongelouts_N_Distaud'] = 25,
    ['Sabiliont']            = 27,
}

local plumeTradeNpc =
{
    onTrade = function(player, npc, trade)
        local tradeEventId = npcTradeEvents[npc:getName()]

        if
            npcUtil.tradeHasExactly(trade, xi.item.PLUME_DOR) and
            not quest:isVarBitsSet(player, 'Option', tradeEventId - 25)
        then
            return quest:progressEvent(tradeEventId)
        end
    end,
}

local plumeOnEventFinish = function(player, csid, option, npc)
    player:confirmTrade()
    quest:setVarBit(player, 'Option', csid - 25)
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                xi.wotg.helpers.hasCompletedFirstQuest(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Louxiard'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(21)
                    elseif
                        questProgress == 1 and
                        not quest:getMustZone(player)
                    then
                        return quest:progressEvent(22)
                    end
                end,
            },

            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(23)
                    end
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    quest:setMustZone(player)
                    quest:setVar(player, 'Prog', 1)
                end,

                [22] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [23] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveItem(player, { { xi.item.PLUME_DOR, 7 } })
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    local plumesTraded = utils.mask.countBits(quest:getVar(player, 'Option'), 7)

                    if
                        not player:hasItem(xi.item.PLUME_DOR) and
                        plumesTraded < 7
                    then
                        local waitTime = quest:getVar(player, 'Timer')

                        if waitTime == 0 then
                            return quest:progressEvent(34)
                        elseif os.time() < waitTime then
                            return quest:event(46)
                        else
                            return quest:progressEvent(35)
                        end
                    elseif plumesTraded == 7 then
                        return quest:progressEvent(24)
                    else
                        return quest:event(33)
                    end
                end,
            },

            ['Elnonde']              = plumeTradeNpc,
            ['Illeuse']              = plumeTradeNpc,
            ['Loillie']              = plumeTradeNpc,
            ['Louxiard']             = plumeTradeNpc,
            ['Machionage']           = plumeTradeNpc,
            ['Rongelouts_N_Distaud'] = plumeTradeNpc,
            ['Sabiliont']            = plumeTradeNpc,

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,

                [25] = plumeOnEventFinish,
                [26] = plumeOnEventFinish,
                [27] = plumeOnEventFinish,
                [28] = plumeOnEventFinish,
                [29] = plumeOnEventFinish,
                [30] = plumeOnEventFinish,
                [31] = plumeOnEventFinish,

                [34] = function(player, csid, option, npc)
                    quest:setVar(player, 'Timer', NextConquestTally())
                end,

                [35] = function(player, csid, option, npc)
                    local numPlumes = 7 - utils.mask.countBits(quest:getVar(player, 'Option'), 7)

                    quest:setVar(player, 'Timer', 0)
                    npcUtil.giveItem(player, { { xi.item.PLUME_DOR, numPlumes } })
                end,
            },
        },
    },
}

return quest
