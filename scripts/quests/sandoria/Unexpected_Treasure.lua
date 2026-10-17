-----------------------------------
-- Unexpected Treasure
-----------------------------------
-- Log ID: 0, Quest ID: 70
-----------------------------------
-- Morunaude : !pos -102.505 -2.261 41.439 231
-- Calovour  : !pos  131.915  0.000 129.446 231
-----------------------------------
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.UNEXPECTED_TREASURE)

quest.reward =
{
    gil = 12000,
}

quest.sections = {}

-- Section 1: Cupboard has been placed in mog house and 1 minutes have elapsed.
quest.sections[1] =
{
    check = function(player, status, vars)
        local cupboardPlacedTime = quest:getVar(player, 'cupboardPlacedTime')

        return status == xi.questStatus.QUEST_AVAILABLE and
            xi.moghouse.inMogHouseInHomeNation(player) and
            player:getFameLevel(player:getNation()) >= 4 and
            not quest:getMustZone(player) and
            cupboardPlacedTime ~= 0 and
            GetSystemTime() > cupboardPlacedTime + 60
    end,
}

-- Moogle presents the Small Teacup that was hidden in the cupboard.
local questAvailable =
{
    ['Moogle'] =
    {
        onTrigger = function(player, npc)
            return quest:progressEvent(30003, 0, 0, 15, xi.item.CUPBOARD, xi.keyItem.SMALL_TEACUP)
        end,
    },

    onEventFinish =
    {
        [30003] = function(player, csid, option, npc)
            npcUtil.giveKeyItem(player, xi.ki.SMALL_TEACUP)
            quest:begin(player)
            quest:setVar(player, 'Prog', 0)
        end,
    },
}

-- Section 2: Quest accepted - speak to Morunaude twice, then trade Mistletoe to Calovour.
quest.sections[2] =
{
    check = function(player, status, vars)
        return status == xi.questStatus.QUEST_ACCEPTED
    end,

    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        ['Morunaude'] =
        {
            onTrigger = function(player, npc)
                local prog = quest:getVar(player, 'Prog')

                if prog == 0 then
                    return quest:progressEvent(635, 0, xi.ki.SMALL_TEACUP, xi.item.CUPBOARD)
                else
                    return quest:progressEvent(636, 0, xi.ki.SMALL_TEACUP, xi.item.CUPBOARD)
                end
            end,
        },

        ['Calovour'] =
        {
            onTrade = function(player, npc, trade)
                if
                    quest:getVar(player, 'Prog') == 3 and
                    npcUtil.tradeHasExactly(trade, xi.item.SPRIG_OF_MISTLETOE)
                then
                    return quest:progressEvent(639, 0, 0, 0, xi.item.SPRIG_OF_MISTLETOE)
                end
            end,

            onTrigger = function(player, npc)
                if quest:getVar(player, 'Prog') == 2 then
                    return quest:progressEvent(637, 0, 0, xi.item.CUPBOARD, xi.item.SPRIG_OF_MISTLETOE)
                elseif quest:getVar(player, 'Prog') == 3 then
                    return quest:progressEvent(638, 0, 0, xi.item.CUPBOARD, xi.item.SPRIG_OF_MISTLETOE)
                end
            end,
        },

        onEventFinish =
        {
            [635] = function(player, csid, option, npc)
                quest:setVar(player, 'Prog', 1)
            end,

            [636] = function(player, csid, option, npc)
                if quest:getVar(player, 'Prog') == 1 then
                    quest:setVar(player, 'Prog', 2)
                end
            end,

            [637] = function(player, csid, option, npc)
                quest:setVar(player, 'Prog', 3)
            end,

            [639] = function(player, csid, option, npc)
                if quest:complete(player) then
                    player:confirmTrade()
                    player:delKeyItem(xi.ki.SMALL_TEACUP)
                end
            end,
        },
    },
}

-- Section 3: Quest completed - repeat dialogue for Morunaude and Calovour.
quest.sections[3] =
{
    check = function(player, status, vars)
        return status == xi.questStatus.QUEST_COMPLETED
    end,

    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        ['Calovour']  = quest:event(640):replaceDefault(),
    },
}

for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
    quest.sections[1][zoneId] = questAvailable
end

return quest
