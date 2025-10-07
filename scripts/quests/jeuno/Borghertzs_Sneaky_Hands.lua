-----------------------------------
-- Borghertz's Sneaky Hands
-----------------------------------
-- Log ID: 3, Quest ID: 49
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_SNEAKY_HANDS,
    handAFId          = xi.item.ROGUES_ARMLETS,
    requiredLogId     = xi.questLog.WINDURST,
    requiredQuestId   = xi.quest.id.windurst.AS_THICK_AS_THIEVES,
    requiredJobId     = xi.job.THF,
    oldGauntletZoneId = xi.zone.MONASTIC_CAVERN,
    optionalZoneId1   = xi.zone.CASTLE_OZTROJA,
    optionalZoneId2   = xi.zone.CASTLE_ZVAHL_BAILEYS,
    optionalArtifact1 = xi.item.ROGUES_CULOTTES,
    optionalArtifact2 = xi.item.ROGUES_VEST,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
