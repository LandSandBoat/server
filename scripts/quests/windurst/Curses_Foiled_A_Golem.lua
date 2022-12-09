-----------------------------------
-- Curses, Foiled A-Golem!?
-----------------------------------
-- !addquest 2 34
-- Shantotto       : !pos 122 -2 112 239
-- Torino-Samarino : !pos 105 -20 140 111
-- Cermet Door     : !pos -183 0 190 204
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_A_GOLEM)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.items.SCROLL_OF_WARP_II,
    title    = xi.title.DOCTOR_SHANTOTTOS_FLAVOR_OF_THE_MONTH,
}

-- Block used by mobs which can remove "Shantotto's New Spell" key item.  This needs
-- verification regarding it being all mobs or if limited to current implementation,
-- and also if there is a chance or limit for kills before removal.
local feiyinMob =
{
    onMobDeath = function(mob, player, optParams)
        if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
            player:delKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL)
            npcUtil.giveKeyItem(player, xi.ki.SHANTOTTOS_EX_SPELL)
        end
    end,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_AGAIN_2) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
                player:getMainLvl() >= 10 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] = quest:progressEvent(340),

            onEventFinish =
            {
                [340] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        player:setTitle(xi.title.TOTAL_LOSER)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        ['Leigon-Moigon'] =
        {
            onTrigger = function(player, npc)
                if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
                    return quest:event(107)
                elseif quest:getVar(player, 'Prog') == 2 then
                    return quest:event(112)
                end
            end,
        },

        ['Potete'] =
        {
            onTrigger = function(player, npc)
                if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
                    return quest:event(106)
                elseif quest:getVar(player, 'Prog') == 2 then
                    return quest:event(111)
                end
            end,
        },

        [xi.zone.BEAUCEDINE_GLACIER] =
        {
            ['Torino-Samarino'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(104)
                    elseif questProgress == 1 then
                        if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
                            return quest:event(105)
                        elseif player:hasKeyItem(xi.ki.SHANTOTTOS_EX_SPELL) then
                            return quest:progressEvent(108)
                        else
                            if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                                return quest:progressEvent(109)
                            else
                                return quest:event(113)
                            end
                        end
                    elseif questProgress == 2 then
                        return quest:event(110)
                    end
                end,
            },

            onEventFinish =
            {
                [104] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.SHANTOTTOS_NEW_SPELL)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [108] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.SHANTOTTOS_EX_SPELL)
                    quest:setVar(player, 'Timer', VanadielUniqueDay() + 1)
                end,

                [109] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SHANTOTTOS_NEW_SPELL)
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            ['_no4'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL) then
                        return quest:progressEvent(14)
                    elseif player:hasKeyItem(xi.ki.SHANTOTTOS_EX_SPELL) then
                        return quest:event(13)
                    end
                end,
            },

            ['Clockwork_Pod'] = feiyinMob,
            ['Colossus']      = feiyinMob,
            ['Droma']         = feiyinMob,
            ['Drone']         = feiyinMob,
            ['Jenglot']       = feiyinMob,
            ['Mind_Hoarder']  = feiyinMob,
            ['Ore_Golem']     = feiyinMob,
            ['Talos']         = feiyinMob,

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:delKeyItem(xi.ki.SHANTOTTOS_NEW_SPELL)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(342)
                    else
                        return quest:event(341)
                    end
                end,
            },

            onEventFinish =
            {
                [342] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] = quest:event(343):replaceDefault(),
        },
    },
}

return quest
