-----------------------------------
-- Area: Upper Jeuno
--  NPC: Guslam
-- Starts Quest: Borghertz's Hands (AF Hands, Many job)
-- !pos -5 1 48 244
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local prerequisites =
{
    [xi.job.WAR] = { log = xi.quest.log_id.BASTOK,   quest = xi.quest.id.bastok.THE_TALEKEEPERS_TRUTH        },
    [xi.job.MNK] = { log = xi.quest.log_id.BASTOK,   quest = xi.quest.id.bastok.THE_FIRST_MEETING            },
    [xi.job.WHM] = { log = xi.quest.log_id.SANDORIA, quest = xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE },
    [xi.job.BLM] = { log = xi.quest.log_id.WINDURST, quest = xi.quest.id.windurst.RECOLLECTIONS              },
    [xi.job.RDM] = { log = xi.quest.log_id.SANDORIA, quest = xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS      },
    [xi.job.THF] = { log = xi.quest.log_id.WINDURST, quest = xi.quest.id.windurst.AS_THICK_AS_THIEVES        },
    [xi.job.PLD] = { log = xi.quest.log_id.SANDORIA, quest = xi.quest.id.sandoria.A_BOY_S_DREAM              },
    [xi.job.DRK] = { log = xi.quest.log_id.BASTOK,   quest = xi.quest.id.bastok.DARK_PUPPET                  },
    [xi.job.BST] = { log = xi.quest.log_id.JEUNO,    quest = xi.quest.id.jeuno.SCATTERED_INTO_SHADOW         },
    [xi.job.BRD] = { log = xi.quest.log_id.JEUNO,    quest = xi.quest.id.jeuno.THE_REQUIEM                   },
    [xi.job.RNG] = { log = xi.quest.log_id.WINDURST, quest = xi.quest.id.windurst.FIRE_AND_BRIMSTONE         },
    [xi.job.SAM] = { log = xi.quest.log_id.OUTLANDS, quest = xi.quest.id.outlands.YOMI_OKURI                 },
    [xi.job.NIN] = { log = xi.quest.log_id.OUTLANDS, quest = xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX      },
    [xi.job.DRG] = { log = xi.quest.log_id.SANDORIA, quest = xi.quest.id.sandoria.CHASING_QUOTAS             },
    [xi.job.SMN] = { log = xi.quest.log_id.WINDURST, quest = xi.quest.id.windurst.CLASS_REUNION              },
}

local function isFirstHandsQuest(player)
    for i = 0, 14 do
        if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + i) == QUEST_COMPLETED then
            return false
        end
    end

    return true
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local mJob = player:getMainJob()
    local prereq = prerequisites[mJob]

    -- HANDS QUEST
    if
        prereq and
        player:getMainLvl() >= 50 and
        player:getCharVar("BorghertzAlreadyActiveWithJob") == 0 and
        player:getQuestStatus(prereq.log, prereq.quest) ~= QUEST_AVAILABLE and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + mJob - 1) == QUEST_AVAILABLE
    then
        player:startEvent(155)
    elseif
        player:getCharVar("BorghertzAlreadyActiveWithJob") >= 1 and
        not player:hasKeyItem(xi.ki.OLD_GAUNTLETS)
    then
        player:startEvent(43)
    elseif player:hasKeyItem(xi.ki.OLD_GAUNTLETS) then
        player:startEvent(26)

        if player:getCharVar("BorghertzCS") == 0 then
            if isFirstHandsQuest(player) then
                if player:getCharVar("BorghertzHandsFirstTime") == 0 then
                    player:setCharVar("BorghertzHandsFirstTime", 1)
                end
            else
                player:setCharVar("BorghertzCS", 1)
            end
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(154)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 155 then
        local mJob = player:getMainJob()

        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + mJob - 1)
        player:setCharVar("BorghertzAlreadyActiveWithJob", mJob)
    end
end

return entity
