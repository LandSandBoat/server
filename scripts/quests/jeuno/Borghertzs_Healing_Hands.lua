-----------------------------------
-- Borghertz's Healing Hands
-----------------------------------
-- Log ID: 3, Quest ID: 46
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_HEALING_HANDS,
    handAFId          = xi.item.HEALERS_MITTS,
    requiredLogId     = xi.questLog.SANDORIA,
    requiredQuestId   = xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE,
    requiredJobId     = xi.job.WHM,
    oldGauntletZoneId = xi.zone.BEADEAUX,
    optionalZoneId1   = xi.zone.CRAWLERS_NEST,
    optionalZoneId2   = xi.zone.GARLAIGE_CITADEL,
    optionalArtifact1 = xi.item.HEALERS_PANTALOONS,
    optionalArtifact2 = xi.item.HEALERS_CAP,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
