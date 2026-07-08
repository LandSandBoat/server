-----------------------------------
-- Borghertz's Lurking Hands
-----------------------------------
-- Log ID: 3, Quest ID: 56
-- Torch         : !pos  63 -24  21 161
-- Guslam        : !pos  -5   1  48 244
-- Deadly Minnow : !pos  -5   1  48 244
-- Yin Pocanakhu : !pos  35   4 -43 245
-- qm1           : !pos -51   8  -4 246
-----------------------------------
require('scripts/quests/jeuno/helpers')
-----------------------------------

local params =
{
    questId           = xi.quest.id.jeuno.BORGHERTZS_LURKING_HANDS,
    handAFId          = xi.item.NINJA_TEKKO,
    requiredLogId     = xi.questLog.OUTLANDS,
    requiredQuestId   = xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX,
    requiredJobId     = xi.job.NIN,
    oldGauntletZoneId = xi.zone.IFRITS_CAULDRON,
    optionalZoneId1   = xi.zone.SEA_SERPENT_GROTTO,
    optionalZoneId2   = xi.zone.THE_BOYAHDA_TREE,
    optionalArtifact1 = xi.item.NINJA_KYAHAN,
    optionalArtifact2 = xi.item.NINJA_HATSUBURI,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
