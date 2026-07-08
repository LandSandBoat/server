-----------------------------------
-- Borghertz's Stalwart Hands
-----------------------------------
-- Log ID: 3, Quest ID: 50
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
    questId           = xi.quest.id.jeuno.BORGHERTZS_STALWART_HANDS,
    handAFId          = xi.item.GALLANT_GAUNTLETS,
    requiredLogId     = xi.questLog.SANDORIA,
    requiredQuestId   = xi.quest.id.sandoria.A_BOYS_DREAM,
    requiredJobId     = xi.job.PLD,
    oldGauntletZoneId = xi.zone.THE_ELDIEME_NECROPOLIS,
    optionalZoneId1   = xi.zone.BEADEAUX,
    optionalZoneId2   = xi.zone.GARLAIGE_CITADEL,
    optionalArtifact1 = xi.item.GALLANT_BREECHES,
    optionalArtifact2 = xi.item.GALLANT_CORONET,
}

local quest = xi.jeuno.helpers.BorghertzQuests:new(params)

return quest
