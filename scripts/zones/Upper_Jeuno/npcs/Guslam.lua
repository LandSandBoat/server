-----------------------------------
-- Area: Upper Jeuno
--  NPC: Guslam
-- Starts Quest: Borghertz's Hands (AF Hands, Many job)
-- !pos -5 1 48 244
-----------------------------------
---@type TNpcEntity
local entity = {}

local prerequisites =
{
    [xi.job.WAR] = { log = xi.questLog.BASTOK,   quest = xi.quest.id.bastok.THE_TALEKEEPERS_TRUTH        },
    [xi.job.MNK] = { log = xi.questLog.BASTOK,   quest = xi.quest.id.bastok.THE_FIRST_MEETING            },
    [xi.job.WHM] = { log = xi.questLog.SANDORIA, quest = xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE },
    [xi.job.BLM] = { log = xi.questLog.WINDURST, quest = xi.quest.id.windurst.RECOLLECTIONS              },
    [xi.job.RDM] = { log = xi.questLog.SANDORIA, quest = xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS      },
    [xi.job.THF] = { log = xi.questLog.WINDURST, quest = xi.quest.id.windurst.AS_THICK_AS_THIEVES        },
    [xi.job.PLD] = { log = xi.questLog.SANDORIA, quest = xi.quest.id.sandoria.A_BOYS_DREAM               },
    [xi.job.DRK] = { log = xi.questLog.BASTOK,   quest = xi.quest.id.bastok.DARK_PUPPET                  },
    [xi.job.BST] = { log = xi.questLog.JEUNO,    quest = xi.quest.id.jeuno.SCATTERED_INTO_SHADOW         },
    [xi.job.BRD] = { log = xi.questLog.JEUNO,    quest = xi.quest.id.jeuno.THE_REQUIEM                   },
    [xi.job.RNG] = { log = xi.questLog.WINDURST, quest = xi.quest.id.windurst.FIRE_AND_BRIMSTONE         },
    [xi.job.SAM] = { log = xi.questLog.OUTLANDS, quest = xi.quest.id.outlands.YOMI_OKURI                 },
    [xi.job.NIN] = { log = xi.questLog.OUTLANDS, quest = xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX      },
    [xi.job.DRG] = { log = xi.questLog.SANDORIA, quest = xi.quest.id.sandoria.CHASING_QUOTAS             },
    [xi.job.SMN] = { log = xi.questLog.WINDURST, quest = xi.quest.id.windurst.CLASS_REUNION              },
}

local function isFirstHandsQuest(player)
    for i = 0, 14 do
        if player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS + i) == xi.questStatus.QUEST_COMPLETED then
            return false
        end
    end

    return true
end

entity.onTrigger = function(player, npc)
    local mJob = player:getMainJob()
    local prereq = prerequisites[mJob]

    -- HANDS QUEST
    if
        prereq and
        player:getMainLvl() >= 50 and
        player:getCharVar('BorghertzAlreadyActiveWithJob') == 0 and
        player:getQuestStatus(prereq.log, prereq.quest) ~= xi.questStatus.QUEST_AVAILABLE and
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS + mJob - 1) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(155)
    elseif
        player:getCharVar('BorghertzAlreadyActiveWithJob') >= 1 and
        not player:hasKeyItem(xi.ki.OLD_GAUNTLETS)
    then
        player:startEvent(43)
    elseif player:hasKeyItem(xi.ki.OLD_GAUNTLETS) then
        player:startEvent(26)

        if player:getCharVar('BorghertzCS') == 0 then
            if isFirstHandsQuest(player) then
                if player:getCharVar('BorghertzHandsFirstTime') == 0 then
                    player:setCharVar('BorghertzHandsFirstTime', 1)
                end
            else
                player:setCharVar('BorghertzCS', 1)
            end
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(154)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 155 then
        local mJob = player:getMainJob()

        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS + mJob - 1)
        player:setCharVar('BorghertzAlreadyActiveWithJob', mJob)
    end
end

return entity
