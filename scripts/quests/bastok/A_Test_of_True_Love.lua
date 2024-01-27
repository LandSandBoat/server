-----------------------------------
-- A Test of True Love
-----------------------------------
-- Log ID: 1, Quest ID: 62
-- Carmelo : !pos -146.476 -7.48 -10.889 236
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 10000,
}

local pageKeyItems =
{
    xi.ki.UN_MOMENT,
    xi.ki.LEPHEMERE,
    xi.ki.LANCIENNE,
}

local function getNumPages(player)
    local numPages = 0

    for _, keyItemId in ipairs(pageKeyItems) do
        if player:hasKeyItem(keyItemId) then
            numPages = numPages + 1
        end
    end

    return numPages
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE) and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 6 and
                not quest:getMustZone(player)
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] = quest:progressEvent(270),

            onEventFinish =
            {
                [270] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        if getNumPages(player) == 3 then
                            return quest:progressEvent(272)
                        else
                            return quest:event(271)
                        end
                    elseif questProgress == 1 then
                        if not quest:getMustZone(player) then
                            return quest:progressEvent(274)
                        else
                            return quest:event(273)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [272] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    quest:setMustZone(player)
                end,

                [274] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setMustZone(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVERS_IN_THE_DUSK)

                        -- TODO: Removing KIs at this step needs to be verified, but given the KI for Lovers in the Dusk
                        -- references they are all arranged, this is most likely correct.

                        for _, keyItemId in ipairs(pageKeyItems) do
                            player:delKeyItem(keyItemId)
                        end
                    end
                end,
            },
        },
    },
}

return quest
