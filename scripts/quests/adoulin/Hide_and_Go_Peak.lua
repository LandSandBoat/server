-----------------------------------
-- Hide and Go Peak
-----------------------------------
-- !addquest 9 57
-- Toppled Tree    : !pos 356.272 -59.701 149.99 266
-- Velkk Cache     : !pos 278.126 -0.378 -80.672 266
-- Scalable Area 2 : !pos 271.483 -59.917 92.095 266
-----------------------------------
local marjamiID = zones[xi.zone.MARJAMI_RAVINE]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.HIDE_AND_GO_PEAK)

-- Note: There are multiple KI rewards here, and A Pair of Velkk Gloves is added prior
-- to the quest complete to cover this.
quest.reward =
{
    fameArea = xi.quest.fame_area.ADOULIN,
    bayld    = 500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.MARJAMI_RAVINE] =
        {
            ['Toppled_Tree'] = quest:progressEvent(3),

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MARJAMI_RAVINE] =
        {
            ['Toppled_Tree'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(4)
                    elseif questProgress == 1 then
                        return quest:progressEvent(5)
                    elseif questProgress == 2 then
                        return quest:event(6)
                    end
                end,
            },

            ['Scalable_Area_2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(7)
                    end
                end,
            },

            ['Velkk_Cache'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.LARGE_STRIP_OF_VELKK_HIDE) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        player:messageSpecial(marjamiID.text.LEATHER_SCRAPS_STREWN)
                        quest:setVar(player, 'Prog', 1)

                        return quest:keyItem(xi.ki.LARGE_STRIP_OF_VELKK_HIDE)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.LARGE_STRIP_OF_VELKK_HIDE)
                    quest:setVar(player, 'Prog', 2)

                    player:messageSpecial(marjamiID.text.KEYITEM_LOST, xi.ki.LARGE_STRIP_OF_VELKK_HIDE)
                end,

                [7] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.PAIR_OF_VELKK_GLOVES)
                    player:addKeyItem(xi.ki.CLIMBING)
                    player:messageSpecial(marjamiID.text.YOU_HAVE_LEARNED, xi.ki.CLIMBING)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
