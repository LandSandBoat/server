-----------------------------------
-- Expertise
-- Variable Prefix: [4][4]
-----------------------------------
-- ZONE,    NPC,     POS
-- Mhaura,  Take,    !pos 20.616  -8.000 69.757 249
-- Selbina, Valgeir, !pos 57.496 -15.273 20.229 248
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/interaction/quest')
-----------------------------------
local mhauraID  = require('scripts/zones/Mhaura/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)
local daysPassed = 0
local hoursLeft  = 0

quest.reward =
{
    item  = xi.items.TABLEWARE_SET,
    title = xi.title.THREE_STAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {

            ['Rycharde'] = quest:event(89),

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getFameLevel(xi.quest.fame_area.WINDURST) > 2 and
                        player:getCharVar("Quest[4][3]DayCompleted") + 8 < VanadielUniqueDay()
                    then
                        return quest:progressEvent(61) -- Quest starting event.
                    else
                        return quest:event(65)
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    player:setCharVar("Quest[4][3]DayCompleted", 0) -- Delete Variable
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(62, xi.items.TABLEWARE_SET) -- Give dish from Valgeir.
                    else
                        return quest:event(63) -- Not goten the dish from Valgeir.
                    end
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.LAND_CRAB_BISQUE) -- Give Land Crab Bisque from Valgeir.
                        player:messageSpecial(mhauraID.text.KEYITEM_OBTAINED + 1, xi.ki.LAND_CRAB_BISQUE)
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Completition day of Expertise quest.
                    end
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(102, xi.items.SCREAM_FUNGUS, xi.items.LAND_CRAB_MEAT) -- Ask for ingredients to cook.
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(104) -- Reminder.
                    elseif quest:getVar(player, 'Prog') == 2 then
                        daysPassed = VanadielDayOfTheYear() - quest:getVar(player, "DayStarted")
                        hoursLeft  = 24 - VanadielHour() - (daysPassed * 24) + quest:getVar(player, "HourStarted")

                        if hoursLeft < 0 then -- Done waiting
                            return quest:progressEvent(105) -- Get food.
                        else
                            return quest:event(141)
                        end
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(142)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.SCREAM_FUNGUS, xi.items.LAND_CRAB_MEAT }) then
                        return quest:progressEvent(103) -- Give ingredients.
                    end
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [103] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'HourStarted', VanadielHour())
                    quest:setVar(player, 'DayStarted', VanadielDayOfTheYear())
                    player:confirmTrade()
                end,

                [105] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.LAND_CRAB_BISQUE)
                end,
            },
        },
    },
}

return quest
