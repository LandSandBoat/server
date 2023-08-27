-----------------------------------
-- Fire and Brimstone (RNG AF2)
-----------------------------------
-- Log ID: 2, Quest ID: 73
-- Perih Vashai: !pos 117 -3 92 241
-- Koh Lenbalalako: !pos -64.412 -17 29.213 249
-- Gravestone: !pos 180 -32 -56 104
-- qm2: !pos -10.946 -1.000 313.810 104
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

-----------------------------------
local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE)

quest.reward =
{
    item     = xi.items.HUNTERS_BERET,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
            player:getMainJob() == xi.job.RNG and
            player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SIN_HUNTING)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(531),

            onEventFinish =
            {
                [531] = function(player, csid, option, npc)
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

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') > 0 and quest:getVar(player, 'Prog') < 4 then
                        return quest:event(532) -- during RNG AF2
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(535, 0, xi.items.TWINSTONE_EARRING, xi.items.OLD_EARRING)
                    elseif quest:getVar(player, 'Prog') == 5 then
                        return quest:event(536, 0, xi.items.TWINSTONE_EARRING, xi.items.OLD_EARRING)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.OLD_EARRING) and
                        quest:getVar(player, 'Prog') == 5
                    then
                        return quest:progressEvent(537, 0, xi.items.TWINSTONE_EARRING)
                    end
                end,
            },

            onEventFinish =
            {
                [535] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [537] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:needToZone(true)
                    end
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Koh_Lenbalalako'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(10007)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 2 then
                        return 10032
                    end
                end,
            },

            onEventFinish =
            {
                [10007] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:setPos(-61.3135, -16.0000, 30.3377, 114, xi.zone.MHAURA)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 2 then
                        return 4
                    end
                end,
            },

            ['Gravestone'] = -- defaultActions TODO -
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(5)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Gioh_Ajihri'] = quest:event(551, 0, xi.items.TWINSTONE_EARRING):importantOnce(),
        },
    },
}

return quest
