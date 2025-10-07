-----------------------------------
-- Borghertz's Harmonious Hands
-----------------------------------
-- Log ID: 3, Quest ID: 53
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_HARMONIOUS_HANDS,
    handAFId          = xi.item.CHORAL_CUFFS,
    requiredLogId     = xi.questLog.JEUNO,
    requiredQuestId   = xi.quest.id.jeuno.THE_REQUIEM,
    requiredJobId     = xi.job.BRD,
    oldGauntletZoneId = xi.zone.CASTLE_ZVAHL_BAILEYS,
    optionalZoneId1   = xi.zone.CASTLE_OZTROJA,
    optionalZoneId2   = xi.zone.CRAWLERS_NEST,
    optionalArtifact1 = xi.item.CHORAL_CANNIONS,
    optionalArtifact2 = xi.item.CHORAL_ROUNDLET,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
