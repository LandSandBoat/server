-----------------------------------
-- Painful Memory
-----------------------------------
-- Log ID: 3, Quest ID: 63
-- Mertaire           !pos -17 0 -61 245
-- Waters of Oblivion !pos -289 -45 212 166
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY)

quest.reward =
{
    item  = xi.item.PAPER_KNIFE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BARD) and
                player:getMainJob() == xi.job.BRD and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
        end,

        [xi.zone.LOWER_JEUNO] =
        {

            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(138)
                    else
                        return quest:progressEvent(137) -- Player declined
                    end
                end,
            },

            onEventFinish =
            {
                [137] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.MERTAIRES_BRACELET)
                    end
                end,

                [138] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Option', 1) -- Player declined
                    else
                        quest:begin(player)
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
        },

        [xi.zone.RANGUEMONT_PASS] =
        {
            ['Tros'] =
            {
                onMobDeath = function(mob, player, optParams)
                    quest:setVar(player, 'Prog', 1)
                end,
            },

            ['Waters_of_Oblivion'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        player:hasKeyItem(xi.ki.MERTAIRES_BRACELET) and
                        progress == 0
                    then
                        npcUtil.popFromQM(player, npc, ID.mob.TROS, { claim = true, hide = 0 }) -- TODO: Should not spawn claimed but navmesh+line of sight make it to where the player can't engage with the mob on spawn.
                        return quest:noAction() -- No message
                    elseif progress == 1 then
                        return quest:progressCutscene(8) -- TODO: Confirm agro is dropped when CS is triggered
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

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] = quest:event(135)
        },
    },
}

return quest
