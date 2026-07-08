-----------------------------------
-- Borghertz's Warring Hands
-----------------------------------
-- Log ID: 3, Quest ID: 44
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_WARRING_HANDS,
    handAFId          = xi.item.FIGHTERS_MUFFLERS,
    requiredLogId     = xi.questLog.BASTOK,
    requiredQuestId   = xi.quest.id.bastok.THE_TALEKEEPERS_TRUTH,
    requiredJobId     = xi.job.WAR,
    oldGauntletZoneId = xi.zone.THE_ELDIEME_NECROPOLIS,
    optionalZoneId1   = xi.zone.CASTLE_ZVAHL_BAILEYS,
    optionalZoneId2   = xi.zone.CRAWLERS_NEST,
    optionalArtifact1 = xi.item.FIGHTERS_CUISSES,
    optionalArtifact2 = xi.item.FIGHTERS_MASK,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
