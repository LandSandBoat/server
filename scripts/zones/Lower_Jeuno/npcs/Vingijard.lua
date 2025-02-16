-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vingijard
-----------------------------------
---@type TNpcEntity
local entity = {}

local jobGearTable =
{
    -- [job ID]     = { Weapon,             Head,                  Body,                    Hands,                     Legs,                     Feet                      },
    -- [xi.job.WAR] = { xi.item.RAZOR_AXE,  xi.item.FIGHTERS_MASK, xi.item.FIGHTERS_LORICA, xi.item.FIGHTERS_MUFFLERS, xi.item.FIGHTERS_CUISSES, xi.item.FIGHTERS_CALLIGAE },
    -- [xi.job.MNK] = { xi.item.BEAT_CESTI, xi.item.TEMPLE_CROWN,  xi.item.TEMPLE_CYCLAS,   xi.item.TEMPLE_GLOVES,     xi.item.TEMPLE_HOSE,      xi.item.TEMPLE_GAITERS    },
    -- [xi.job.WHM] = {  },
    -- [xi.job.BLM] = {  },
    -- [xi.job.RDM] = {  },
    -- [xi.job.THF] = {  },
    -- [xi.job.PLD] = {  },
    -- [xi.job.DRK] = {  },
    -- [xi.job.BST] = {  },
    -- [xi.job.BRD] = {  },
    -- [xi.job.RNG] = {  },
    -- [xi.job.SAM] = {  },
    -- [xi.job.NIN] = {  },
    -- [xi.job.DRG] = {  },
    -- [xi.job.SMN] = {  },
    -- [xi.job.BLU] = {  },
    -- [xi.job.COR] = {  },
    -- [xi.job.PUP] = {  },
    -- [xi.job.DNC] = {  },
    -- [xi.job.SCH] = {  },
    -- [xi.job.GEO] = {  },
    -- [xi.job.RUN] = {  },
}

local jobQuestsTable =
{

    [xi.job.WAR] =
    {
        [1] = { xi.questLog.BASTOK, xi.quest.id.bastok.THE_DOORMAN             },
        [2] = { xi.questLog.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_TRUTH   },
        [3] = { xi.questLog.BASTOK, xi.quest.id.bastok.THE_TALEKEEPERS_GIFT    },
        [4] = { xi.questLog.JEUNO,  xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS },
    },
    [xi.job.MNK] =
    {
        [1] = { xi.questLog.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST       },
        [2] = { xi.questLog.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING        },
        [3] = { xi.questLog.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH            },
        [4] = { xi.questLog.JEUNO,  xi.quest.id.jeuno.BORGHERTZS_STRIKING_HANDS },
    },
    [xi.job.WHM] =
    {
        [1] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND      },
        [2] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE },
        [3] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.PIEUJES_DECISION           },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_HEALING_HANDS      },
    },
    [xi.job.BLM] =
    {
        [1] = { xi.questLog.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI          },
        [2] = { xi.questLog.WINDURST, xi.quest.id.windurst.RECOLLECTIONS           },
        [3] = { xi.questLog.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_SORCEROUS_HANDS },
    },
    [xi.job.RDM] =
    {
        [1] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_CRIMSON_TRIAL        },
        [2] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS    },
        [3] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT     },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_VERMILLION_HANDS },
    },
    [xi.job.THF] =
    {
        [1] = { xi.questLog.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN  },
        [2] = { xi.questLog.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES    },
        [3] = { xi.questLog.WINDURST, xi.quest.id.windurst.HITTING_THE_MARQUISATE },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_SNEAKY_HANDS   },
    },
    [xi.job.PLD] =
    {
        [1] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD   },
        [2] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.A_BOYS_DREAM           },
        [3] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.UNDER_OATH             },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_STALWART_HANDS },
    },
    [xi.job.DRK] =
    {
        [1] = { xi.questLog.BASTOK, xi.quest.id.bastok.DARK_LEGACY             },
        [2] = { xi.questLog.BASTOK, xi.quest.id.bastok.DARK_PUPPET             },
        [3] = { xi.questLog.BASTOK, xi.quest.id.bastok.BLADE_OF_EVIL           },
        [4] = { xi.questLog.JEUNO,  xi.quest.id.jeuno.BORGHERTZS_SHADOWY_HANDS },
    },
    [xi.job.BST] =
    {
        [1] = { xi.questLog.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD         },
        [2] = { xi.questLog.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW },
        [3] = { xi.questLog.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN            },
        [4] = { xi.questLog.JEUNO, xi.quest.id.jeuno.BORGHERTZS_WILD_HANDS },
    },
    [xi.job.BRD] =
    {
        [1] = { xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY              },
        [2] = { xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM                 },
        [3] = { xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME          },
        [4] = { xi.questLog.JEUNO, xi.quest.id.jeuno.BORGHERTZS_HARMONIOUS_HANDS },
    },
    [xi.job.RNG] =
    {
        [1] = { xi.questLog.WINDURST, xi.quest.id.windurst.SIN_HUNTING           },
        [2] = { xi.questLog.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE    },
        [3] = { xi.questLog.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION     },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_CHASING_HANDS },
    },
    [xi.job.SAM] =
    {
        [1] = { xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA   },
        [2] = { xi.questLog.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI          },
        [3] = { xi.questLog.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG     },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_LOYAL_HANDS },
    },
    [xi.job.NIN] =
    {
        [1] = { xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS },
        [2] = { xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX  },
        [3] = { xi.questLog.OUTLANDS, xi.quest.id.outlands.TRUE_WILL              },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_LURKING_HANDS  },
    },
    [xi.job.DRG] =
    {
        [1] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.A_CRAFTSMANS_WORK    },
        [2] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS       },
        [3] = { xi.questLog.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER       },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_DRAGON_HANDS },
    },
    [xi.job.SMN] =
    {
        [1] = { xi.questLog.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER     },
        [2] = { xi.questLog.WINDURST, xi.quest.id.windurst.CLASS_REUNION         },
        [3] = { xi.questLog.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE     },
        [4] = { xi.questLog.JEUNO,    xi.quest.id.jeuno.BORGHERTZS_CALLING_HANDS },
    },
    [xi.job.BLU] =
    {
        [1] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS      },
        [2] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS           },
        [3] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS },
    },
    [xi.job.COR] =
    {
        [1] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS     },
        [2] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS },
        [3] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS               },
    },
    [xi.job.PUP] =
    {
        [1] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATION },
        [2] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME      },
        [3] = { xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES     },
    },
    [xi.job.DNC] =
    {
        [1] = { xi.questLog.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ },
        [2] = { xi.questLog.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM  },
        [3] = { xi.questLog.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN       },
    },
    [xi.job.SCH] =
    {
        [1] = { xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL    },
        [2] = { xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX   },
        [3] = { xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_BLOOD_RED },
    },
    [xi.job.GEO] =
    {
    },
    [xi.job.RUN] =
    {
    },
}

local function isJobResetingEligible(player, jobId)
    -- Check for gear table job entry existence.
    if jobGearTable[jobId] == nil then
        return false
    end

    -- Check for quest table job entry existence.
    if jobQuestsTable[jobId] == nil then
        return false
    end

    -- Check if player still has any of the job AF pieces.
    for gearPiece = 1, #jobGearTable[jobId] do
        if player:hasItem(jobGearTable[jobId][gearPiece]) then
            return false
        end
    end

    -- Check if the player has completed all job AF quests.
    for questEntry = 1, #jobQuestsTable[jobId] do
        if not player:hasCompletedQuest(jobQuestsTable[jobId][questEntry][1], jobQuestsTable[jobId][questEntry][2]) then
            return false
        end
    end

    return true
end

local function performJobResetting(player, jobId)
    -- Safety check.
    if not isJobResetingEligible(player, jobId) then
        return
    end

    -- Delete all quests.
    for questEntry = 1, #jobQuestsTable[jobId] do
        player:delQuest(jobQuestsTable[jobId][questEntry][1], jobQuestsTable[jobId][questEntry][2])
    end
end

entity.onTrigger = function(player, npc)
    local currentGil    = player:getGil()
    local optionBitmask = 8388606 -- 23 bits. 1st = false. 2nd to 23th = true.

    -- Build option bitmask.
    for jobId = xi.job.WAR, xi.job.RUN do
        if isJobResetingEligible(player, jobId) then
            optionBitmask = optionBitmask - bit.lshift(1, jobId)
        end
    end

    player:startEvent(10034, optionBitmask, currentGil)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 10034 and
        option >= xi.job.WAR and
        option <= xi.job.RUN and
        player:getGil() >= 10000 -- Safety check.
    then
        performJobResetting(player, option)
    end
end

return entity
