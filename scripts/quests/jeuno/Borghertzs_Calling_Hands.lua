-----------------------------------
-- Borghertz's Calling Hands
-----------------------------------
-- Log ID: 3, Quest ID: 58
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_CALLING_HANDS,
    handAFId          = xi.item.EVOKERS_BRACERS,
    requiredLogId     = xi.questLog.WINDURST,
    requiredQuestId   = xi.quest.id.windurst.CLASS_REUNION,
    requiredJobId     = xi.job.SMN,
    oldGauntletZoneId = xi.zone.SEA_SERPENT_GROTTO,
    optionalZoneId1   = xi.zone.TEMPLE_OF_UGGALEPIH,
    optionalZoneId2   = xi.zone.TORAIMARAI_CANAL,
    optionalArtifact1 = xi.item.EVOKERS_DOUBLET,
    optionalArtifact2 = xi.item.EVOKERS_PIGACHES,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
