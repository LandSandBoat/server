-----------------------------------
-- Borghertz's Chasing Hands
-----------------------------------
-- Log ID: 3, Quest ID: 54
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_CHASING_HANDS,
    handAFId          = xi.item.HUNTERS_BRACERS,
    requiredLogId     = xi.questLog.WINDURST,
    requiredQuestId   = xi.quest.id.windurst.FIRE_AND_BRIMSTONE,
    requiredJobId     = xi.job.RNG,
    oldGauntletZoneId = xi.zone.GARLAIGE_CITADEL,
    optionalZoneId1   = xi.zone.CRAWLERS_NEST,
    optionalZoneId2   = xi.zone.MONASTIC_CAVERN,
    optionalArtifact1 = xi.item.HUNTERS_BRACCAE,
    optionalArtifact2 = xi.item.HUNTERS_JERKIN,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
