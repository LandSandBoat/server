-----------------------------------
-- An Undying Pledge
-----------------------------------
-- Log ID: 5, Quest ID: 149
-- Stray Cloud : !pos -18 1 -20 252
-- qm5         : !pos 133 -9 221 176
-----------------------------------
local ssgID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.AN_UNDYING_PLEDGE)

quest.reward =
{
    item     = xi.item.LIGHT_BUCKLER,
    fameArea = xi.fameArea.NORG,
    fame     = 50,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.NORG) >= 4
        end,

        [xi.zone.NORG] =
        {
            ['Stray_Cloud'] = quest:progressEvent(225),

            onEventFinish =
            {
                [225] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Stray_Cloud'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        return quest:event(228)
                    elseif prog == 1 then
                        return quest:event(229)
                    elseif prog == 3 then
                        return quest:progressEvent(227)
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(226)
                    end
                end,
            },

            onEventFinish =
            {
                [226] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [227] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CALIGINOUS_BLADE)
                    end
                end,
            },
        },

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if
                        prog == 1 and
                        npcUtil.popFromQM(player, npc, ssgID.mob.GLYRYVILU, { claim = true, hide = 0 })
                    then
                        return quest:messageSpecial(ssgID.text.BODY_NUMB_DREAD)
                    elseif prog == 2 then
                        return quest:progressEvent(18)
                    end
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CALIGINOUS_BLADE)
                    quest:setVar(player, 'Prog', 3)
                end,
            },

            ['Glyryvilu'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.NORG] =
        {
            ['Stray_Cloud'] = quest:event(230):replaceDefault(),
        },
    },
}

return quest
