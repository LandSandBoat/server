-----------------------------------
-- Sharpening The Sword PLD AF 1
-- !addquest 0 90
-----------------------------------
-- Ailbeche: !pos 5.6 .5 25.2 231
-- Sobane: !pos -190 -2.9 97 230
-- Stalagmite: !pos -48 .5 .2 193
-----------------------------------
local ordellesID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD)

quest.reward =
{
    item     = xi.item.HONOR_SWORD,
    fame     = 30,
    fameArea = xi.fameArea.SANDORIA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getMainJob() == xi.job.PLD and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
                player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON) == xi.questStatus.QUEST_COMPLETED and
                player:getCharVar('Quest[0][4]Prog') == 0 -- must have turned the willow fishing rod back
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(45) -- Starts Quest.
                    elseif quest:getVar(player, 'Prog') == 1 then --declined first
                        return quest:progressEvent(43)
                    end
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                    else
                        quest:setVar(player, 'Prog', 1) -- Declined First offering.
                    end
                end,

                [43] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ORDELLE_WHETSTONE) then
                        return quest:progressEvent(44)
                    else
                        return quest:event(42)
                    end
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ORDELLE_WHETSTONE)
                    end
                end,
            },

        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(52)
                    end
                end,
            },

            onEventFinish =
            {
                [52] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.ORDELLES_CAVES] =
        {
            ['Stalagmite'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 3 and
                        quest:getVar(player, 'nmKilled') == 0 and
                        npcUtil.popFromQM(player, npc, ordellesID.mob.POLEVIK, { claim = true, hide = 0 })
                    then
                        return player:messageSpecial(ordellesID.text.SENSE_OF_FOREBODING)
                    elseif
                        questProgress == 3 and
                        quest:getVar(player, 'nmKilled') == 1
                    then
                        npcUtil.giveKeyItem(player, xi.ki.ORDELLE_WHETSTONE)
                        quest:setVar(player, 'nmKilled', 0)
                        quest:setVar(player, 'Prog', 4)
                        return quest:noAction()
                    end
                end,
            },

            ['Polevik'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },
        },
    },
}

return quest
