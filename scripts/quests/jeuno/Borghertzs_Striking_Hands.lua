-----------------------------------
-- Borghertz's Striking Hands
-----------------------------------
-- Log ID: 3, Quest ID: 45
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_STRIKING_HANDS,
    handAFId          = xi.item.TEMPLE_GLOVES,
    requiredLogId     = xi.questLog.BASTOK,
    requiredQuestId   = xi.quest.id.bastok.THE_FIRST_MEETING,
    requiredJobId     = xi.job.MNK,
    oldGauntletZoneId = xi.zone.CRAWLERS_NEST,
    optionalZoneId1   = xi.zone.BEADEAUX,
    optionalZoneId2   = xi.zone.GARLAIGE_CITADEL,
    optionalArtifact1 = xi.item.TEMPLE_CYCLAS,
    optionalArtifact2 = xi.item.TEMPLE_CROWN,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
