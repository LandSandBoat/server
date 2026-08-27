-----------------------------------
-- The Kuftal Tour
-----------------------------------
-- Log ID : 5, Quest ID: 195
-- Datta  : !pos -24.768 8.324 70.722 247
-- qm5    : !pos -29.195 -22.159 -183.716 174
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_KUFTAL_TOUR)

quest.reward =
{
    gil   = 8000,
    title = xi.title.KUFTAL_TOURIST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.THE_GUSTABERG_TOUR) and
                player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 3
        end,

        [xi.zone.RABAO] =
        {
            ['Datta'] = quest:progressEvent(74),

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.KUFTAL_TUNNEL] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    local flag = true

                    for _, member in pairs(player:getAlliance()) do
                        if
                            member:getMainLvl() > 40 or
                            member:checkDistance(player) > 15
                        then
                            flag = false
                        end
                    end

                    if flag and #player:getParty() > 1 then
                        return quest:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.RABAO] =
        {
            ['Datta'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(75)
                    end
                end,
            },

            onEventFinish =
            {
                [75] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:addFame(xi.fameArea.SANDORIA, 10)
                    player:addFame(xi.fameArea.BASTOK, 10)
                end,
            },
        },
    },
}

return quest
