-----------------------------------
-- A Bitter Past
-----------------------------------
-- Log ID: 4, Quest ID: 66
-- Frescheque : !pos 18 -36 12 26
-- Raminey    : !pos 82 -35 50 26
-- Equette    : !pos 3 -22 -17 26
-- ???        : !pos 58 -7 27 24
-----------------------------------
local lufaiseID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_BITTER_PAST)
local orcNM = lufaiseID.mob.BLACKBONE_FRAZDIZ

quest.reward =
{
    item = xi.item.YINYANG_LORGNETTE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Frescheque'] = quest:progressEvent(151),

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Frescheque'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TINY_WRISTLET) then
                        return quest:progressEvent(154)
                    end
                end,
            },
            ['Raminey'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(152)
                    end
                end,
            },
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(153)
                    end
                end,
            },

            onEventFinish =
            {
                [152] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [153] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [154] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TINY_WRISTLET)
                    end
                end,
            },
        },

        [xi.zone.LUFAISE_MEADOWS] =
        {
            ['qm_bitter_past'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        quest:getVar(player, 'nmKilled') ~= 1 and
                        npcUtil.popFromQM(player, npc, { orcNM, orcNM + 1 }, { claim = true, hide = 0 })
                    then
                        return quest:messageText(lufaiseID.text.SENSE_OF_FOREBODING)
                    elseif
                        quest:getVar(player, 'nmKilled') == 1 and
                        not player:hasKeyItem(xi.ki.TINY_WRISTLET)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.TINY_WRISTLET)
                        return quest:noAction()
                    end
                end,
            },

            ['Blackbone_Frazdiz'] =
            {
                onMobDeath = function(mob, player)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        GetMobByID(orcNM + 1):isDead()
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            ['Rainbringer_Yjatvot'] =
            {
                onMobDeath = function(mob, player)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        GetMobByID(orcNM):isDead()
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStaus.QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(155):importantOnce()
                end,
            },
        },
    },
}

return quest
