-----------------------------------
-- Faded Promises
-----------------------------------
-- Log ID: 1, Quest ID: 73
-- Romualdo : !gotoid 17748022
-- Ayame : !gotoid 17748015
-- Palborough_Mines chest: !gotoid 17363374
-- Kagetora : !gotoid 17743879
-- Alois : !gotoid 17747997

-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FADED_PROMISES)

quest.reward =
{
    fame     = 10,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.FUKURO,
    title    = xi.title.ASSASSIN_REJECT,

}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainJob() == xi.job.NIN and
            player:getMainLvl() >= 20 and
            player:getFameLevel(xi.quest.fame_area.NORG) >= 4
        end,

        [xi.zone.METALWORKS] =
        {
            ['Romualdo'] = quest:progressEvent(802),

            onEventFinish =
            {
                [802] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(803)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(804)
                    end
                end,
            },

            ['Alois'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(805)
                    end
                end,
            },

            onEventFinish =
            {
                [803] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [804] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [805] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.DIARY_OF_MUKUNDA)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 and player:hasKeyItem(xi.ki.DIARY_OF_MUKUNDA) then
                        return quest:progressEvent(296)
                    else
                        return quest:event(23)
                    end
                end,
            },

            onEventFinish =
            {
                [296] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
}

return quest
