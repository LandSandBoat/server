-----------------------------------
-- Painful Memory
-----------------------------------
-- Log ID: 3, Quest ID: 63
-- Mertaire: !pos -719.617 -7.135 101.606 245
-- Waters_of_Oblivion: !pos -287.717 -45.002 211.928 166
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)

quest.reward =
{
    item = xi.item.PAPER_KNIFE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
            player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD) and
            player:getMainJob() == xi.job.BRD
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    local initialCS = quest:getVar(player, 'Option')

                    if initialCS == 0 then
                        return quest:progressEvent(138)
                    elseif initialCS == 1 then
                        return quest:event(137):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [138] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Option', 0)
                        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,

                [137] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Option ', 0)
                        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] = quest:event(136),

            ['Mataligeat'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 1 then
                        return quest:event(141)
                    end
                end,
            },
        },

        [xi.zone.RANGUEMONT_PASS] =
        {
            ['Waters_of_Oblivion'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if
                        prog == 0 and
                        player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) and
                        npcUtil.popFromQM(player, npc, ID.mob.TROS, { claim = true, hide = 0 })
                    then
                        return quest:noAction()
                    elseif prog == 1 then
                        return quest:progressCutscene(8)
                    end
                end,
            },

            ['Tros'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.MERTAIRES_BRACELET)
                    end
                end,
            },
        },
    },
}

return quest
