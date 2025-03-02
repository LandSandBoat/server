-----------------------------------
-- Grimy Signposts
-----------------------------------
-- Log ID: 0, Quest ID: 66
-----------------------------------
-- Maugie    : !pos 105 2 -16 230
-- Signpost  : !pos 301 0 419 104
-- Signpost  : !pos -457 2 -416 104
-- Signpost  : !pos -260 0 -23 104
-- Signpost  : !pos -73 2 100 104
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS)

quest.reward =
{
    gil = 1500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 2
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Maugie'] = quest:progressEvent(45),

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog < 15
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Maugie'] = quest:event(43),
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Signpost'] =
            {
                onTrigger = function(player, npc)
                    local info =
                    {
                        [0] = 9,
                        [1] = 8,
                        [2] = 7,
                        [3] = 6,
                    }
                    local offset = npc:getID() - ID.npc.SIGNPOST[1]
                    local data = info[offset]

                    if data and not quest:isVarBitsSet(player, 'Prog', data - 6) then
                        return quest:progressCutscene(data, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(ID.text.SIGNPOST_NEW)
                        quest:setVarBit(player, 'Prog', 0)
                    end
                end,

                [7] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(ID.text.SIGNPOST_NEW)
                        quest:setVarBit(player, 'Prog', 1)
                    end
                end,

                [8] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(ID.text.SIGNPOST_NEW)
                        quest:setVarBit(player, 'Prog', 2)
                    end
                end,

                [9] = function(player, csid, option, npc)
                    if option == 1 then
                        player:messageSpecial(ID.text.SIGNPOST_NEW)
                        quest:setVarBit(player, 'Prog', 3)
                    end
                end,
            }
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
            vars.Prog == 15
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Maugie'] = quest:progressEvent(44),

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Maugie'] = quest:event(42):replaceDefault(),
        },
    },
}

return quest
