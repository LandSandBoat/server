-----------------------------------
-- The Dismayed Customer
-----------------------------------
-- Log ID: 0, Quest ID: 6
-- Gulemont : !pos -69 -5 -38 232
-- qm1      : !pos -453 -20 -230 100
-- qm2      : !pos -550 -0 -542 100
-- qm3      : !pos -399 -10 -438 100
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_DISMAYED_CUSTOMER)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 560,
    title = xi.title.LOST_FOUND_OFFICER,
}

local function handleQm(player, qmNumber)
    if quest:getVar(player, 'Stage') == qmNumber then
        quest:setVar(player, 'Stage', 0)
        return quest:keyItem(xi.ki.GULEMONTS_DOCUMENT)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_TASTE_FOR_MEAT)
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Gulemont'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(605)
                end,
            },

            onEventFinish =
            {
                [605] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'Stage', math.random(1, 3))
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Gulemont'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.GULEMONTS_DOCUMENT) then
                        return quest:progressEvent(607)
                    else
                        return quest:progressEvent(606)
                    end
                end,
            },

            onEventFinish =
            {
                [607] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.GULEMONTS_DOCUMENT)
                    end
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    return handleQm(player, 1)
                end,
            },

            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    return handleQm(player, 2)
                end,
            },

            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    return handleQm(player, 3)
                end,
            },
        },
    },
}

return quest
