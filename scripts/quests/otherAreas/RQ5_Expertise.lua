-----------------------------------
-- Expertise
-- Variable Prefix: [4][4]
-----------------------------------
-- ZONE,    NPC,     POS
-- Mhaura,  Take,    !pos 20.616  -8.000 69.757 249
-- Selbina, Valgeir, !pos 57.496 -15.273 20.229 248
-----------------------------------
local mhauraID  = zones[xi.zone.MHAURA]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)

quest.reward =
{
    item  = xi.item.TABLEWARE_SET,
    title = xi.title.THREE_STAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {

            ['Rycharde'] = quest:event(89),

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getFameLevel(xi.fameArea.WINDURST) > 2 and
                        player:getCharVar('Quest[4][3]DayCompleted') + 8 < VanadielUniqueDay()
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
                    player:setCharVar('Quest[4][3]DayCompleted', 0) -- Delete Variable
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(62, xi.item.TABLEWARE_SET) -- Give dish from Valgeir.
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
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(102, xi.item.SCREAM_FUNGUS, xi.item.SLICE_OF_LAND_CRAB_MEAT) -- Ask for ingredients to cook.

                    elseif questProgress == 1 then
                        return quest:event(104) -- Reminder.

                    elseif questProgress == 2 then
                        local readyTime = quest:getVar(player, 'readyTime')

                        if readyTime <= os.time() then -- Done waiting
                            return quest:progressEvent(105) -- Get food.
                        else
                            return quest:event(141)
                        end

                    elseif questProgress == 3 then
                        return quest:event(142)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.SCREAM_FUNGUS, xi.item.SLICE_OF_LAND_CRAB_MEAT }) then
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
                    quest:setVar(player, 'readyTime', os.time() + 24 * 144) -- Current time + 24 hours * 144 real seconds (Thats the ammount of seconds a Vana'Diel hour takes)
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
