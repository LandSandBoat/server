-----------------------------------
-- A Hard Day's Knight
-----------------------------------
-- Log ID: 4, Quest ID: 64
-- Quelveuiat          : !pos -3.177 -22.750 -25.970 26
-- qm_hard_days_knight : !pos -38.605 -9.022 -290.700 24
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local lufaiseID = require('scripts/zones/Lufaise_Meadows/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_HARD_DAYS_KNIGHT)

quest.reward =
{
    gil = 2100,
    title = xi.title.TAVNAZIAN_SQUIRE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Quelveuiat'] = quest:progressEvent(119),

            onEventFinish =
            {
                [119] = function(player, csid, option, npc)
                    if option == 3 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Quelveuiat'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(120)
                    elseif questProgress == 1 then
                        return quest:progressEvent(121)
                    end
                end,
            },

            onEventFinish =
            {
                [121] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            ['qm_hard_days_knight'] =
            {
                onTrigger = function(player, npc)
                    if
                        not GetMobByID(lufaiseID.mob.SPLINTERSPINE_GRUKJUK):isSpawned() and
                        quest:getVar(player, 'Prog') < 1
                    then
                        player:messageSpecial(lufaiseID.text.SURVEY_THE_SURROUNDINGS)
                        SpawnMob(lufaiseID.mob.SPLINTERSPINE_GRUKJUK):updateClaim(player)
                        return quest:messageSpecial(lufaiseID.text.MURDEROUS_PRESENCE)
                    end
                end,
            },

            ['Splinterspine_Grukjuk'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Quelveuiat'] =
            {
                onTrade = function(player, npc, trade)
                    -- TODO: Needs verification for single-trade events
                    if not player:hasKeyItem(xi.ki.TEMPLE_KNIGHT_KEY) then
                        if
                            npcUtil.tradeHasExactly(trade, xi.items.SEALION_CREST_KEY) or
                            npcUtil.tradeHasExactly(trade, xi.items.CORAL_CREST_KEY)
                        then
                            return quest:progressEvent(631, trade:getItemId())
                        elseif npcUtil.tradeHasExactly(trade, { xi.items.SEALION_CREST_KEY, xi.items.CORAL_CREST_KEY }) then
                            quest:setVar(player, 'Prog', 2)
                            return quest:progressEvent(631, xi.items.SEALION_CREST_KEY, xi.items.CORAL_CREST_KEY)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local itemCount = 0
                    local itemTable = { 0, 0 }

                    for itemId = xi.items.SEALION_CREST_KEY, xi.items.CORAL_CREST_KEY do
                        if player:findItem(itemId) then
                            itemCount = itemCount + 1
                            itemTable[itemCount] = itemId
                        end
                    end

                    return quest:progressEvent(631, itemTable[1], itemTable[2])
                end,
            },

            onEventFinish =
            {
                [631] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(632)
                    end
                end,

                [632] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 0)
                    return quest:keyItem(xi.ki.TEMPLE_KNIGHT_KEY)
                end
            },
        },
    },
}

return quest
