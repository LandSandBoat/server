-----------------------------------
-- Borghertz's Vermillion Hands
-----------------------------------
-- Log ID: 3, Quest ID: 48
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_VERMILLION_HANDS,
    handAFId          = xi.item.WARLOCKS_GLOVES,
    requiredLogId     = xi.questLog.SANDORIA,
    requiredQuestId   = xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS,
    requiredJobId     = xi.job.RDM,
    oldGauntletZoneId = xi.zone.THE_ELDIEME_NECROPOLIS,
    optionalZoneId1   = xi.zone.CASTLE_OZTROJA,
    optionalZoneId2   = xi.zone.GARLAIGE_CITADEL,
    optionalArtifact1 = xi.item.WARLOCKS_TABARD,
    optionalArtifact2 = xi.item.WARLOCKS_TIGHTS,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
