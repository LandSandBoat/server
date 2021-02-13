-----------------------------------
-- Area: Upper Jeuno
--  NPC: Guslam
-- Starts Quest: Borghertz's Hands (AF Hands, Many job)
-- !pos -5 1 48 244
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local prerequisites =
{
    [tpz.job.WAR] = { log = tpz.quest.log_id.BASTOK,   quest = tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH       },
    [tpz.job.MNK] = { log = tpz.quest.log_id.BASTOK,   quest = tpz.quest.id.bastok.THE_FIRST_MEETING            },
    [tpz.job.WHM] = { log = tpz.quest.log_id.SANDORIA, quest = tpz.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE },
    [tpz.job.BLM] = { log = tpz.quest.log_id.WINDURST, quest = tpz.quest.id.windurst.RECOLLECTIONS              },
    [tpz.job.RDM] = { log = tpz.quest.log_id.SANDORIA, quest = tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS      },
    [tpz.job.THF] = { log = tpz.quest.log_id.WINDURST, quest = tpz.quest.id.windurst.AS_THICK_AS_THIEVES        },
    [tpz.job.PLD] = { log = tpz.quest.log_id.SANDORIA, quest = tpz.quest.id.sandoria.A_BOY_S_DREAM              },
    [tpz.job.DRK] = { log = tpz.quest.log_id.BASTOK,   quest = tpz.quest.id.bastok.DARK_PUPPET                  },
    [tpz.job.BST] = { log = tpz.quest.log_id.JEUNO,    quest = tpz.quest.id.jeuno.SCATTERED_INTO_SHADOW         },
    [tpz.job.BRD] = { log = tpz.quest.log_id.JEUNO,    quest = tpz.quest.id.jeuno.THE_REQUIEM                   },
    [tpz.job.RNG] = { log = tpz.quest.log_id.WINDURST, quest = tpz.quest.id.windurst.FIRE_AND_BRIMSTONE         },
    [tpz.job.SAM] = { log = tpz.quest.log_id.OUTLANDS, quest = tpz.quest.id.outlands.YOMI_OKURI                 },
    [tpz.job.NIN] = { log = tpz.quest.log_id.OUTLANDS, quest = tpz.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX      },
    [tpz.job.DRG] = { log = tpz.quest.log_id.SANDORIA, quest = tpz.quest.id.sandoria.CHASING_QUOTAS             },
    [tpz.job.SMN] = { log = tpz.quest.log_id.WINDURST, quest = tpz.quest.id.windurst.CLASS_REUNION              },
}

local function isFirstHandsQuest(player)
    local count = 0

    for i = 0, 14 do
        if player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + i) == QUEST_COMPLETED then
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
        player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + mJob - 1) == QUEST_AVAILABLE
    then
        player:startEvent(155)
    elseif player:getCharVar("BorghertzAlreadyActiveWithJob") >= 1 and not player:hasKeyItem(tpz.ki.OLD_GAUNTLETS) then
        player:startEvent(43)
    elseif player:hasKeyItem(tpz.ki.OLD_GAUNTLETS) then
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

        player:addQuest(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.BORGHERTZ_S_WARRING_HANDS + mJob - 1)
        player:setCharVar("BorghertzAlreadyActiveWithJob", mJob)
    end
end

return entity
