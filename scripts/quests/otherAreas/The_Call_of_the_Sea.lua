-----------------------------------
-- The Call of the Sea
-----------------------------------
-- Log ID: 4, Quest ID: 67
-- Equette          !pos 1.260 -22.438 -18.161
-- Leporaitceau     !pos 74.981 -24.835 11.786
-- Anteurephiaux    !pos 81.063 -24.977 -2.481
-- QM Bloody Coffin !pos 641.281 0.295 -516.568
-----------------------------------
local misareuxID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_CALL_OF_THE_SEA)

quest.reward =
{
    item = xi.item.MEMENTO_MUFFLER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Anteurephiaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(172)
                    end
                end,
            },

            ['Equette'] = quest:progressEvent(170),
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(170)
                    end
                end,
            },

            -- This is a missable optional cutscene that can play either before or during the quest.
            ['Leporaitceau'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(171)
                    end
                end,
            },

            onEventFinish =
            {
                [170] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [171] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [172] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Anteurephiaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(173)
                    end
                end,
            },

            ['Equette'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(174)
                    end
                end,
            },

            -- This is a missable optional cutscene that can play either before or during the quest.
            ['Leporaitceau'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(171)
                    end
                end,
            },

            onEventFinish =
            {
                [171] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [173] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.WHISPERING_CONCH)
                    quest:setVar(player, 'Prog', 4)
                end,

                [174] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['Bloody_Coffin'] =
            {
                onMobDeath = function(mob, player, optParams)
                    player:setLocalVar('NMKilled', 1)
                end,
            },

            ['qm_bloody_coffin'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')
                    if
                        progress == 2 and
                        player:getLocalVar('NMKilled') == 1
                    then
                        npcUtil.giveKeyItem(player, xi.ki.WHISPERING_CONCH)
                        quest:setVar(player, 'Prog', 3)
                        return quest:noAction()
                    elseif
                        progress == 2 and
                        not GetMobByID(misareuxID.mob.BLOODY_COFFIN):isSpawned()
                    then
                        npcUtil.popFromQM(player, npc, misareuxID.mob.BLOODY_COFFIN, { claim = true, hide = 0 })
                        return quest:messageSpecial(misareuxID.text.FOUL_STENCH_OF_DEATH)
                    end
                end,
            },
        },
    },
}

return quest
