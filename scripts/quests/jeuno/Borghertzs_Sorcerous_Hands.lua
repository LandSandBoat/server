-----------------------------------
-- Borghertz's Sorcerous Hands
-----------------------------------
-- Log ID: 3, Quest ID: 47
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_SORCEROUS_HANDS,
    handAFId          = xi.item.WIZARDS_GLOVES,
    requiredLogId     = xi.questLog.WINDURST,
    requiredQuestId   = xi.quest.id.windurst.RECOLLECTIONS,
    requiredJobId     = xi.job.BLM,
    oldGauntletZoneId = xi.zone.GARLAIGE_CITADEL,
    optionalZoneId1   = xi.zone.MONASTIC_CAVERN,
    optionalZoneId2   = xi.zone.THE_ELDIEME_NECROPOLIS,
    optionalArtifact1 = xi.item.WIZARDS_COAT,
    optionalArtifact2 = xi.item.WIZARDS_TONBAN,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
